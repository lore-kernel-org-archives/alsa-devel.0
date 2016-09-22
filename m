From: nick <xerofoify@gmail.com>
Subject: Re: Oxygen Possible Bug in FCM
Date: Thu, 22 Sep 2016 00:17:56 -0400
Message-ID: <071b745f-eb48-6a3f-9190-12ab89b0fed4@gmail.com>
References: <CAPDOMViD16uP7o9nHo16gfvpayev-cY_M_ftBC+4jGdenwjY5w@mail.gmail.com>
 <472de8b1-4f99-78e4-96f3-056e108ee0f7@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f195.google.com (mail-qk0-f195.google.com
 [209.85.220.195])
 by alsa0.perex.cz (Postfix) with ESMTP id AF6BE266819
 for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2016 06:17:59 +0200 (CEST)
Received: by mail-qk0-f195.google.com with SMTP id z143so4453911qka.3
 for <alsa-devel@alsa-project.org>; Wed, 21 Sep 2016 21:17:59 -0700 (PDT)
In-Reply-To: <472de8b1-4f99-78e4-96f3-056e108ee0f7@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 2016-09-21 02:47 AM, Clemens Ladisch wrote:
> xerofoify wrote:
>> Do anyone known of the best way to test this function,
>> ac97_fp_rec_volume_put. Seems there may be a bug in
>> it.
> 
> What bug?
> 
>> I do have the hardware so that's not a issue just wondering what
>> the different between fp_rec and the standard
>> get functions are in terms of testing.
> 
> The other functions use five bits, this one uses three bits.
> 
That's not what I am getting at seems ac97_fp_rec_volume_get is similar in
logic to ac97_fp_rec_volume_put and therefore in ac97_fp_rec_volume_get:

value->value.integer.value[1] = (reg >> 8) & 7;

is different then  ac97_fp_rec_volume_put:

newreg = newreg | ((value->value.integer.value[0] & 7) << 8);

which is is probably accessing an incorrect value in the sound card register
array, at least from my understanding of reading this driver. It seems it 
should be accessing the value in index 1 of this particular array of sound card
registers. 
> (The AC'97 spec says the REC_GAIN register has four bits for the volume;
> I don't know where the difference comes from.)
> 
> And the REC_GAIN register should affect all recorded signals going
> through the AC'97 mixer (all except line in).
> 
>> Further more I am assuming this
>> has to do with the fp headphones switch
>> but I don't have headphones that are fp so is there another way to
>> test this particular function without checking
>> sound levels.
> 
> You could connect any microphone to the front panel connector.
> 
> Or check the AC'97 registers in /proc/asound/cardX/oxygen.
> 
OK that seems the easy way to test that the incorrect access I stated above is 
actually a issue. Probably best to test it as dealing with registers on hardware
as this can easily lead to regressions and that's why I am asking.
Thanks,
Nick
> 
> Regards,
> Clemens
> 
