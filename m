From: Sid Boyce <sboyce@blueyonder.co.uk>
Subject: Re: 2.6.35-rc3 E-MU 0404 USB problem
Date: Thu, 24 Jun 2010 03:17:47 +0100
Message-ID: <4C22C04B.5070407@blueyonder.co.uk>
References: <4C20B364.9060405@blueyonder.co.uk> <20100622131102.GA18432@kroah.com> <20100622133434.GZ2698@buzzloop.caiaq.de> <4C21E875.20200@blueyonder.co.uk> <4C2201DF.9050500@ladisch.de>
Reply-To: sboyce@blueyonder.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C2201DF.9050500@ladisch.de>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: alsa-user@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 23/06/10 13:45, Clemens Ladisch wrote:
>>>> Sid Boyce wrote:
>>>>> Transmit fails,
>
> What exactly fails?
>
The application uses the on-board HDA Intel sound card for Mic and 
Speaker output.
For receive, data from the receiver goes to the E-MU 0404 USB at ~10 
KHz where it is digitized then processed by the application and comes 
out the speaker as audio - that works at 48K, 96K and 192K sample rate.

For transmission you speak into the mic and it's processed by the 
application, digitized and sent to the E-MU 0404 USB where it's 
converted to audio that is used to modulate the transmitter and out to 
the antenna - that doesn't work even at 48K sample rate, i.e there is no 
output from the E-MU 0404 USB.
.
>>>>> dmesg output with 48K sample rate set is:-
>>>>> ALSA sound/usb/clock.c:214: 6:2:3: endpoint lacks sample rate attribute bit, cannot set.
>
> There are many devices that have only one sample rate or that have one
> sample rate per alternate setting.  This doesn't deserve a message, much
> less a warning.
>
>
> Regards,
> Clemens
>

On another box with the Terratec Aureon 5.1 USB card, it works both ways 
at 48K sample rate though the audio going to the transmitter is 
insufficient to drive the transmitter to the expected output.
Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support
Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks
