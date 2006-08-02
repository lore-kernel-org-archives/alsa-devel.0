From: Krivenok Dmitry <_asr_@inbox.ru>
Subject: Re: =?koi8-r?b?VmlydHVhbCBzb3VuZCBjYXJk?=
Date: Wed, 02 Aug 2006 21:31:18 +0400
Message-ID: <E1G8KYw-000HVH-00._asr_-inbox-ru@f51.mail.ru>
References: <s5hwt9rhzn7.wl%tiwai=40suse.de>
Reply-To: Krivenok Dmitry <_asr_@inbox.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: =?koi8-r?Q?<s5hwt9rhzn7.wl%tiwai=40suse.de>?=
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



-----Original Message-----
From: Takashi Iwai <tiwai@suse.de>
To: Krivenok Dmitry <_asr_@inbox.ru>
Date: Wed, 02 Aug 2006 18:26:52 +0200
Subject: Re: [Alsa-devel] Virtual sound card

> 
> At Wed, 02 Aug 2006 16:16:03 +0400,
> Krivenok Dmitry wrote:
> > 
> > Hello All!
> >  
> > What is the simplest way to implement virtual sound card?
> > Special kernel module, which represents virtual device driver? Special plugin? 
> > Or something else?
> 
> How about JACK?
> 
> We have already some alsa-lib plugins, such as file plugin.
> You can record a PCM stream to a file while using another real
> device.
> 

Yes, I know about file plugin. 
It works fine with commands like this:
aplay -D file myfile.wav

Unfortunately, I don't know how to use it with Skype (new version, which supports ALSA).
Skype supports real cards (e.g. my VIA8233) and virtual cards (e.g. dummy), i.e.
devices with ALSA interface.
But "file" isn't ALSA-device.

How to combine file plugin with alsa-device? Is it possible at all?

> 
> Takashi
> 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
