From: sh_okada@d4.dion.ne.jp
Subject: Re: New alsa lowlevel driver for the SE-200PCI and
 SE-90PCI
Date: Sat, 13 Oct 2007 00:05:43 +0900
Message-ID: <D25C927.1DC0.sh_okada@d4.dion.ne.jp>
References: <s5h7ilt9555.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dsmtp4.dion.ne.jp (mail.dion.ne.jp [61.117.3.52])
	by alsa0.perex.cz (Postfix) with ESMTP id 78A1524399
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Oct 2007 17:05:38 +0200 (CEST)
Received: from d4.dion.ne.jp (x007160.ppp.dion.ne.jp [210.234.7.160])
	by dsmtp4.dion.ne.jp (8.11.7p3+Sun/8.11.7/050303) with SMTP id
	l9CF5Y222347
	for <alsa-devel@alsa-project.org>; Sat, 13 Oct 2007 00:05:34 +0900 (JST)
In-reply-to: Your message of "Thu, 11 Oct 2007 15:01:42 JST."
	<s5h7ilt9555.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, sh_okada@d4.dion.ne.jp
List-Id: alsa-devel@alsa-project.org

>Well, the current code still doesn't follow properly.
>Below are some nitpickings.

Thank you for a detailed check. 
A new one put my HP
http://www.d4.dion.ne.jp/~sh_okada/misc/alsa-SE200PCI.patch-3.tgz


>You don't need braces around a single-line if, for example,
>
>>	if (ice->eeprom.subvendor == VT1724_SUBDEVICE_SE90PCI) {
>>		/* nothing to do */
>>	}
>>	else if (ice->eeprom.subvendor == VT1724_SUBDEVICE_SE200PCI) {
>>		se200pci_add_controls(ice);
>>	}
>
>should be
>
>>	if (ice->eeprom.subvendor == VT1724_SUBDEVICE_SE90PCI)
>>		/* nothing to do */
>>	else if (ice->eeprom.subvendor == VT1724_SUBDEVICE_SE200PCI)
>>		se200pci_add_controls(ice);

This becomes a compile error,
Because when omitting it

	if (A) else if (B) func();

It needs ';' or '{}'
like
	if (A) ; else if (B) func();
or
	if (A) {} else if (B) func();

Therefore, "/* nothing to do */" cannot be written by this style.
When forcibly writing It becomes tricky. 

	if (A)
		/* nothing to do */;
	else if (B)
		func();

or

	if (A) {
		/* nothing to do */
	} else if (B)
		func();


So I wrote as

	/* nothing to do for VT1724_SUBDEVICE_SE90PCI */
	if (ice->eeprom.subvendor == VT1724_SUBDEVICE_SE200PCI)
		err = se200pci_add_controls(ice);


>> 2  The name of the control
>
>Now looks better.  One remaining thing is you're using an enum control
>for "ACG Capture Switch".  If it's a switch, you should use a boolean
>type.

AGC has some modes, but now coded one mode.
It makes it to such a style, Because it is likely to be going
to increase it in the future.

now      OFF, ON(type=1)
future   OFF, ON(type=1), ON(type=2),...


Thanks
