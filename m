From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Issue with Intel HDA Sound card 82801G
	(laptop	Medion)
Date: Sat, 07 Oct 2006 10:37:39 -0700
Message-ID: <1160242659.17297.64.camel@razman>
References: <1160227460.4527aa8501646@imp1-g19.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1160227460.4527aa8501646@imp1-g19.free.fr>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: albox@free.fr
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Sorry about that.  Had a final project for class last week that took all
my time (had to watch O' Brother, Where Art Thou ~20 times, pulling
clips, snapshots, and quotes - yuk).  I don't have another class until
10/31.

>From your last email, it looks like your laptop is configured as a
3-stack system in Bios:
hda_codec: Unknown model for ALC883, trying auto-probe from BIOS...
autoconfig: line_outs=3 (0x14/0x15/0x16/0x0/0x0)
speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
inputs: mic=0x0, fmic=0x18, line=0x1a, fline=0x0, cd=0x0, aux=0x0

It's possible that you need a gpio to enable output, similar to acer,
but using gpio2 instead of 1.

Try applying this patch, then changing th model to
"model=6stack-dig-demo"

diff -r aa73a3902052 pci/hda/patch_realtek.c
--- a/pci/hda/patch_realtek.c   Fri Oct 06 18:41:42 2006 +0200
+++ b/pci/hda/patch_realtek.c   Sat Oct 07 10:32:27 2006 -0700
@@ -5139,7 +5141,7 @@ static struct alc_config_preset alc883_p
        },
        [ALC888_DEMO_BOARD] = {
                .mixers = { alc883_base_mixer, alc883_chmode_mixer },
-               .init_verbs = { alc883_init_verbs },
+               .init_verbs = { alc883_init_verbs,
alc880_gpio1_init_verbs, alc880_gpio2_init_verbs },
                .num_dacs = ARRAY_SIZE(alc883_dac_nids),
                .dac_nids = alc883_dac_nids,
                .dig_out_nid = ALC883_DIGOUT_NID,



This should enable everything.  Send me the output
of /proc/asound/card0/codec#0 and dmesg (make sure to compile with
debug=detect like last time).

Tobin

On Sat, 2006-10-07 at 15:24 +0200, albox@free.fr wrote:
> Hi,
> I sent an email 2 weeks ago about an issue with my sound card : Intel HDA Sound
> card 82801G (laptop Medion).
> http://sourceforge.net/mailarchive/forum.php?thread_id=30643877&forum_id=1752
> 
> It seems that I'm not the only person having an issue with this sound card :
> http://sourceforge.net/mailarchive/forum.php?thread_id=30685342&forum_id=1752
> 
> Tobin Davis answered me and helped me but I didn't fix the bug yet.
> I tried adding "options snd model=acer" to my /etc/modprobe.conf file with the
> last version of the asla drivers...
> Next Tobin asked me for the log messages but he didn't answer me yet (I guess he
> is too busy). So, I want to try to fix the problem by myself but I'd like some
> help to start. Can somebody tell me where can I start to look to detect the
> problem ?
> 
> Thank you
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
-- 
Tobin Davis <tdavis@dsl-only.net>


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
