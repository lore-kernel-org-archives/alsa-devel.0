From: Andrea Venturi <a.venturi@avalpa.com>
Subject: Re: SOLVED: Re: Dell Studio 15 - aka Inspiron 1535
 sound problems: HDA intel and codec IDT (STAC) 92HD73C1X5
Date: Wed, 06 Aug 2008 23:11:18 +0200
Message-ID: <489A1376.3040005@avalpa.com>
References: <48987087.4040001@avalpa.com> <48995ECF.2040607@avalpa.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070808030107080103080609"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out26.alice.it (smtp-out26.alice.it [85.33.2.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B83C10394C
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Aug 2008 23:11:45 +0200 (CEST)
In-Reply-To: <48995ECF.2040607@avalpa.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070808030107080103080609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrea Venturi wrote:
> Andrea Venturi wrote:
>> hi, i own a brand new Dell laptop Studio 15
>>
>> the audio speakers stay mute if i play an audio file. :-|
>>
>
> now it works (more or less).

hi. i'm back again with a little issue.

the sound max volume is not as high as the other OS standard.

i had a little thread in the Dell Linux mailing list about this issue:

  http://lists.us.dell.com/pipermail/linux-desktops/2008-August/001808.html


and, to make a long story short, Dell's Mario Limonciello told me that 
the max master volume has been reduced from 0xff to 0xec, to solve some 
distortion (resonance) issues at higher levels, with this commit:

http://git.alsa-project.org/?p=alsa-kernel.git;a=commit;h=d654a660355f9dc30d3a6bf1493d32363bde8570

this is not going to change until there's some Band EQualization 
software support in the alsa driver that can reduce this resonance 
issues at higher volume levels.

do you know if something like this is in development?

i gave a quick look to the Stac/IDT 92HD73C1XXX codec datasheet 
http://www.idt.com/?genID=92HD73C1 and i'm going to believe there's no 
HW support about band filtering..  (the datasheet indeed speaks about a 
SigmaTel Kernel Processing Interface AKA /SKPI/ ) so it should it be a 
complete software solution for linux too! right?

bye

andrea venturi


--------------070808030107080103080609
Content-Type: text/x-vcard; charset=utf-8;
 name="a_venturi.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="a_venturi.vcf"

begin:vcard
fn:Andrea Venturi
n:;Andrea Venturi
org:Avalpa Digital Engineering SRL
adr;dom:;;Via dell'Arcoveggio 49/5;Bologna;BO;40129
email;internet:a.venturi@avalpa.com
title:CEO
tel;work:+39 0514187531
tel;cell:+39 3477142994
url:www.avalpa.com
version:2.1
end:vcard


--------------070808030107080103080609
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------070808030107080103080609--
