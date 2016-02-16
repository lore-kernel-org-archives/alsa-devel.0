From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] sound: hdmi: avoid dereferencing
	uninitialized 'jack' pointer
Date: Tue, 16 Feb 2016 17:59:04 +0100
Message-ID: <112888486.mQgaWiH0PI@wuerfel>
References: <1455634059-1896914-1-git-send-email-arnd@arndb.de>
 <s5h4md87hnu.wl-tiwai@suse.de> <20160216163840.GA7544@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 859EC2608BC
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 17:59:23 +0100 (CET)
In-Reply-To: <20160216163840.GA7544@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Han Lu <han.lu@intel.com>, Libin Yang <libin.yang@linux.intel.com>, Thierry Reding <treding@nvidia.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Tuesday 16 February 2016 16:38:40 Mark Brown wrote:
> On Tue, Feb 16, 2016 at 05:18:29PM +0100, Takashi Iwai wrote:
> > Arnd Bergmann wrote:
> 
> > > Another option might would be to change snd_jack_new() to return
> > > an error if that SND_JACK is disabled, and then require all users
> > > to handle the error gracefully, i.e. not fail the probe() function
> > > but just not use the jack.
> 
> > Yes, I thought of that, too.  If select is no good option, it's a good
> > alternative, indeed.
> 
> It's going to be a bunch of work to implement though.
> 

I've already sent a v2 to change the snd_jack_new() function, feel free
to ignore that. I also saw now that the same bug is present in hda_jack.c,
but I think the other drivers are fine.

How about this approach below? That should also make it possible to
use the jack APIs without using a error return.

	Arnd

diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index a33234e04d4f..2f72b3c09d92 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -403,8 +403,10 @@ int snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
 
 	jack->phantom_jack = !!phantom_jack;
 	jack->type = type;
-	jack->jack->private_data = jack;
-	jack->jack->private_free = hda_free_jack_priv;
+	if (IS_ENABLED(CONFIG_SND_JACK)) {
+		jack->jack->private_data = jack;
+		jack->jack->private_free = hda_free_jack_priv;
+	}
 	state = snd_hda_jack_detect(codec, nid);
 	snd_jack_report(jack->jack, state ? jack->type : 0);
 
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index f4443b5fbf6e..e9a0f67c92ca 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2532,8 +2532,10 @@ static int add_hdmi_jack_kctl(struct hda_codec *codec,
 		return err;
 
 	spec->pcm_rec[pcm_idx].jack = jack;
-	jack->private_data = &spec->pcm_rec[pcm_idx];
-	jack->private_free = free_hdmi_jack_priv;
+	if (IS_ENABLED(CONFIG_SND_JACK)) {
+		jack->private_data = &spec->pcm_rec[pcm_idx];
+		jack->private_free = free_hdmi_jack_priv;
+	}
 	return 0;
 }
 
