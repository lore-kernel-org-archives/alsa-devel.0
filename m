From: "Viliam Kubis" <viliam.kubis@gmail.com>
Subject: Re: Smart 5.1 function not working on VIA VT1708S with
 *three* jacks on mainboard
Date: Sat, 10 Jul 2010 14:39:11 +0200
Message-ID: <op.vfmn3k2py9cctd@localhost>
References: <AANLkTim0B4gB4X1SfURg_NF4-gnJ3GTGjCH1PIVwBtfD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id E9735245DB
	for <alsa-devel@alsa-project.org>;
	Sat, 10 Jul 2010 14:39:14 +0200 (CEST)
Received: by bwz4 with SMTP id 4so1694069bwz.38
	for <alsa-devel@alsa-project.org>; Sat, 10 Jul 2010 05:39:12 -0700 (PDT)
In-Reply-To: <AANLkTim0B4gB4X1SfURg_NF4-gnJ3GTGjCH1PIVwBtfD@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Raymond
	Yau <superquad.vortex2@gmail.com>
List-Id: alsa-devel@alsa-project.org

But my speakers only come with two jacks for input. One for the front  
speakers and one for rear speakers. So I cannot connect the speakers to  
all three jacks. I have compiled alsa with --with-debug=full configure  
option to see which pins it has auto-parsed:

HDA Intel 0000:00:14.2: PCI INT A disabled
HDA Intel 0000:00:14.2: PCI INT A -> GSI 16 (level, low) -> IRQ 16
ALSA hda_codec.c:4408: autoconfig: line_outs=1 (0x1c/0x0/0x0/0x0/0x0)
ALSA hda_codec.c:4412:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
ALSA hda_codec.c:4416:    hp_outs=1 (0x1d/0x0/0x0/0x0/0x0)
ALSA hda_codec.c:4417:    mono: mono_out=0x0
ALSA hda_codec.c:4420:    dig-out=0x20/0x0
ALSA hda_codec.c:4428:    inputs: mic=0x1a, fmic=0x1e, line=0x1b,  
fline=0x0, cd=0x1f, aux=0x0

However in function smart51_get, the following condition

if (ctl & AC_PINCTL_IN_EN
     && !(ctl & AC_PINCTL_OUT_EN))
{
	printk(KERN_INFO "*** PATCH on=0 in via_smart51_get()");
	on = 0;
}

will never be true, so smart51_get will always set  
*ucontrol->value.integer.value to 1. (printk line will not execute)

Smart 5.1 control gets created and appears to be "working". However  
surround output does not work.

On Sat, 10 Jul 2010 11:41:35 +0200, Raymond Yau  
<superquad.vortex2@gmail.com> wrote:

>>> It might be. It is important not to mix VT1708 and VT1708S. For  
>>> VT1708S,
> the following DACs are used in code:
>
>   /* config dac list */
>   switch (i) {
>   case AUTO_SEQ_FRONT:
>   	spec->multiout.dac_nids[i] = 0x10;
>   	break;
>   case AUTO_SEQ_CENLFE:
>   	spec->multiout.dac_nids[i] = 0x24;
>   	break;
>   case AUTO_SEQ_SURROUND:
>   	spec->multiout.dac_nids[i] = 0x11;
>   	break;
>   case AUTO_SEQ_SIDE:
>   	spec->multiout.dac_nids[i] = 0x25;
>   	break;
>   }
>
>>>  So 0x12 is not used for any of the surround outputs.
>
> I think your testing config is not compiled with smart 5.1 requirement
>
> Refer to smart51_get() , this function exepct red jack and blue jack
> are configued to Output
>
> But you still plugged in Mic into the pink jack according to your photo.
>
> Your speakers have to plugged in both pink and blue jacks
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


-- 
Using Opera's revolutionary e-mail client: http://www.opera.com/mail/
