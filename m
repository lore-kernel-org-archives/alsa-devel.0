From: "Dr. Alexander K. Seewald" <alex@seewald.at>
Subject: Re: Status of Dolby Digital on-the-fly encoding? (via
	a52	plugin)
Date: Tue, 18 Dec 2007 15:52:30 +0100
Message-ID: <20071218145230.GA3861@sdg.at>
References: <20071211132249.GA12802@sdg.at> <s5hlk7t1ulb.wl%tiwai@suse.de>
	<20071217210338.GA30887@sdg.at> <s5hsl20xlce.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from seewald.at (seewald.at [213.208.134.200])
	by alsa0.perex.cz (Postfix) with ESMTP id DA57824508
	for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2007 15:53:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hsl20xlce.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 18, 2007 at 01:01:53PM +0100, Takashi Iwai wrote:
> > Problem seems to lie deeper...
> Sounds so.  Which hardware and driver is it?
* NVidia CK804 (integrated into the motherboard MSI K8N Neo4 Platinum)

aplay -l:

card 0: CK804 [NVidia CK804], device 0: Intel ICH [NVidia CK804]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: CK804 [NVidia CK804], device 2: Intel ICH - IEC958 [NVidia
CK804 - IEC958]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

* Alsa drivers 1.0.8-7 (= latest stable version on Debian Sarge)
[2.6.11 kernel, Debian sarge]

I used to have a wav-file which played 5.1 audio using these drivers,
but have misplaced it. But I think it was encoded into DTS 96/24 (96kHz,
24bit samples) which is IMHO not supported by any plugin. This means
that the connection probably works, but the internal hardware Dolby
Digital decoder is not happy with the format, right?

Best,
  Alex
-- 
Dr. Alexander K. Seewald         +43(664)1106886
              Seewald Solutions                 
------------------------------------------------
         Information wants to be free;
Information also wants to be expensive (S.Brant)
--------------- alex.seewald.at ----------------
