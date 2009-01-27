From: "Keith A. Milner" <maillist@superlative.org>
Subject: Re: Help with Behringer UCG102 Quirks
Date: Tue, 27 Jan 2009 11:10:58 +0000
Message-ID: <200901271110.58339.maillist@superlative.org>
References: <200901261844.03194.maillist@superlative.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mercury.safeukdns.net (mercury.safeukdns.net [77.92.84.1])
	by alsa0.perex.cz (Postfix) with ESMTP id 12C931037EA
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 12:11:03 +0100 (CET)
Received: from grenville.superlative.org ([82.152.152.239]
	helo=asmodeus.superlative.org)
	by mercury.safeukdns.net with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69) (envelope-from <maillist@superlative.org>)
	id 1LRlqM-00076P-Nm
	for alsa-devel@alsa-project.org; Tue, 27 Jan 2009 11:10:59 +0000
In-Reply-To: <200901261844.03194.maillist@superlative.org>
Content-Disposition: inline
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

On Monday 26 January 2009 18:44:02 Keith A. Milner wrote:
> Hi,
> I'm new to alsa development work so I would appreciate some advice.
>
> I'm trying to add specific support for the Behringer UCG102 Guitar Link USB
> interface. This is a simple device based on a TI codec. The aim is twofold:
>
> a) To provide a more descriptive name, as it currently describes itself as
> the generic TI device
>
> This was easy... I've included the following in usbquirks.h:
>
> /* Behringer UCG102 Guitar Link */
> {
> 	USB_DEVICE(0x08bb, 0x2902),
> 	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
> 		.vendor_name = "Behringer",
> 		.product_name = "Guitar Link UCG102",
> 		.ifnum = QUIRK_ANY_INTERFACE,
> 		.type = QUIRK_COMPOSITE,
> 	}
> },

OK, I've just worked out this is a generic vid/pid which applies to multiple 
cards, so this is out of the window.


-- 
Keith A. Milner
