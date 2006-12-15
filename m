From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: ALC880 driver
Date: Fri, 15 Dec 2006 10:39:47 +1030 (CST)
Message-ID: <200612150009.kBF09lEZ028693@turbo.physics.adelaide.edu.au>
References: <45811EA6.6040103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45811EA6.6040103@gmail.com> from "Trifon Trifonov" at Dec 14,
	2006 10:51:34 AM
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Trifon Trifonov <triffon@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, PeiSen Hou <pshou@realtek.com.tw>, Kailang Yang <kailang@realtek.com.tw>, alsa-devel@lists.sourceforge.net, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hi Trifon

[ Alsa-devel list added to CC ]

> I have a Realtek IntelHDA audio card using the ALC880 codec. I am 
> runing Ubuntu Linux with kernel version 2.6.17-10.
> When I first installed Ubuntu, it correctly recognised my card, but I 
> could hear audio only through the right speaker. I looked in my kern.log 
> and found a message that it is recognised as ALC880, but the vendor is 
> unknown. I inspected the file patch_realtek.c for possible board config 
> types and experimented with all of them. Some were not working at all, 
> some were working again with only right speaker, some were working with 
> both speakers, but microphone input is not working. Finally, I found 
> that the W810 config is right for me -- everything is working stereo and 
> also the input. I have no problems with the card, just wanted to share 
> the knowledge so maybe you can add automatic detection for my type of 
> card to work on the W810 config.
> Please, write to me what kind of additional information do you need 
> for that.

Could you please provide the following information:

 1) The make and model of your laptop

 2) The output of the following commands:

      lspci
      lspci -nv

    Depending on your system's configuration you may have to include the
    full path when running lspci - for example, "/sbin/lspci".

Thanks
  jonathan

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
