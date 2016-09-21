From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Oxygen Possible Bug in FCM
Date: Wed, 21 Sep 2016 08:47:00 +0200
Message-ID: <472de8b1-4f99-78e4-96f3-056e108ee0f7@ladisch.de>
References: <CAPDOMViD16uP7o9nHo16gfvpayev-cY_M_ftBC+4jGdenwjY5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id C12B2266EC5
 for <alsa-devel@alsa-project.org>; Wed, 21 Sep 2016 08:47:02 +0200 (CEST)
In-Reply-To: <CAPDOMViD16uP7o9nHo16gfvpayev-cY_M_ftBC+4jGdenwjY5w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: xerofoify <xerofoify@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

xerofoify wrote:
> Do anyone known of the best way to test this function,
> ac97_fp_rec_volume_put. Seems there may be a bug in
> it.

What bug?

> I do have the hardware so that's not a issue just wondering what
> the different between fp_rec and the standard
> get functions are in terms of testing.

The other functions use five bits, this one uses three bits.

(The AC'97 spec says the REC_GAIN register has four bits for the volume;
I don't know where the difference comes from.)

And the REC_GAIN register should affect all recorded signals going
through the AC'97 mixer (all except line in).

> Further more I am assuming this
> has to do with the fp headphones switch
> but I don't have headphones that are fp so is there another way to
> test this particular function without checking
> sound levels.

You could connect any microphone to the front panel connector.

Or check the AC'97 registers in /proc/asound/cardX/oxygen.


Regards,
Clemens
