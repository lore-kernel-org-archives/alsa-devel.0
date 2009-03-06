From: "Christopher J. Atherton" <the8lack8ox@gmail.com>
Subject: Re: No headphone output on HT Omega Claro Halo
Date: Fri, 06 Mar 2009 17:45:28 -0500
Message-ID: <49B1A788.1050404@gmail.com>
References: <49B0965A.1040208@gmail.com> <49B0F9F3.2060208@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.250])
	by alsa0.perex.cz (Postfix) with ESMTP id 222312444E
	for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2009 23:45:32 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id c5so594235rvf.32
	for <alsa-devel@alsa-project.org>; Fri, 06 Mar 2009 14:45:31 -0800 (PST)
In-Reply-To: <49B0F9F3.2060208@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Christopher J. Atherton wrote:
>> I have an HT Omega Claro Halo (CMI8878) card that is not entirely
>> working.  This card has two analog outputs, a pair of RCA connectors and
>> also a separate headphone output (3.5mm jack).  The RCA outputs work,
>> but the headphone output, which notably passes a signal from a built in
>> headphone amp, does not.
> 
> Please try this patch:
> 
> --- linux/sound/pci/oxygen/oxygen.c
> +++ linux/sound/pci/oxygen/oxygen.c
> @@ -200,6 +200,8 @@ static void halo_init(struct oxygen *chip)
>  {
>  	ak4396_init(chip);
>  	ak5385_init(chip);
> +	oxygen_set_bits16(chip, OXYGEN_GPIO_CONTROL, 0x100);
> +	oxygen_set_bits16(chip, OXYGEN_GPIO_DATA, 0x100);
>  }
>  
>  static void generic_cleanup(struct oxygen *chip)

That did the trick.  Many thanks!  However, I've now noticed that the
PCM volume control doesn't work at all, which is somewhat inconvenient
since the card is very loud and Master only makes my 64 ohm headphones
comfortable at "5" (-25 dB).

-- Kristoff
