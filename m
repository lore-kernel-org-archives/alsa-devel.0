From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [Alsa-user] Metallic recording in cs46xx
 on	Thinkpad T22
Date: Thu, 13 Mar 2008 13:56:04 +0100
Message-ID: <47D92464.9070107@keyaccess.nl>
References: <3948f0730803110024k1e7b90ecr31b745e333913c1d@mail.gmail.com>	<47D70143.3010705@keyaccess.nl>	<s5hk5k89f52.wl%tiwai@suse.de>	<47D80754.1020400@keyaccess.nl>	<s5h8x0nanew.wl%tiwai@suse.de>	<47D81037.7030901@keyaccess.nl>
	<s5hwso699y3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id A8BB324443
	for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2008 13:55:23 +0100 (CET)
In-Reply-To: <s5hwso699y3.wl%tiwai@suse.de>
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
Cc: alsa-user@lists.sourceforge.net, ALSA devel <alsa-devel@alsa-project.org>, Gadi Oron <gadior@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 13-03-08 11:48, Takashi Iwai wrote:

>> Hmm, alsa-info.sh freshly downloaded from current hg.
> 
> Is the original data also truncated at the middle or is it a paste.bin
> problem?

The script only uploaded it. When I intervene and look at /tmp/alsa-info.txt 
manually it's complete but when I just now retried the output on pastebin.ca 
is again truncated:

http://pastebin.ca/940954

>> 	control.26 {
>> 		comment.access 'read write'
>> 		comment.type INTEGER
>> 		comment.count 2
>> 		comment.range '0 - 32767'
>> 		iface MIXER
>> 		name 'ADC Volume'
>> 		value.0 29492
>> 		value.1 29492
>> 	}
> 
> Try to put this to full once.

No change. Also no change with capturing at 48000/16/2 (previous 44100/16/2) 
nor 44100/8/2, nor 44100/16/1.

Rene.
