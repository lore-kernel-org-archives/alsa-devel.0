Return-Path: <alsa-devel-bounces@alsa-project.org>
Message-ID: <a077d6ac9b13495df8e2d049aa5f3e78.squirrel@mungewell.org>
In-Reply-To: <570F4832.9020302@ladisch.de>
References: <3d5a5368f3a43ffc0114daf09c306d7e.squirrel@mungewell.org>
 <570E0AE0.3020507@ladisch.de>
 <32e8a05d90e5cfd79622802c340948ab.squirrel@mungewell.org>
 <570F4832.9020302@ladisch.de>
Date: Thu, 14 Apr 2016 10:20:26 -0600
From: "Simon Wood" <simon@mungewell.org>
MIME-Version: 1.0
Subject: Re: [alsa-devel] Tascam US-122L - Corrupt USB descriptor
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: linux-usb@vger.kernel.org, alsa-devel@vger.kernel.org
List-ID: <alsa-devel@alsa-project.org>

On Thu, April 14, 2016 1:35 am, Clemens Ladisch wrote:
> Simon Wood wrote:
>
>> The card shows up under '/proc/asound/cards', but only as Midi.
>>
>
> Apparently, there is no PCM device. This driver creates a special
> hardware-dependent device which is intended to be used with the Jack driver
> "usb_stream".
>
>
> It might be possible to use the ALSA "usb_stream" plugin:
> <http://www.alsa-project.org/main/index.php/Matrix:Module-usb-us122l>

I have this '.asoundrc' file (made before previous postings), but that
does not seem to make a usable card.

I'm expecting that a PCM device should /just/ appear under 'aplay -l', but
that is not happening. Perhaps there is a step I am missing, or I am just
confused about what qualifies a 'working' US-122L.

Do I need to be using a specific version of (userland) Alsa?

It would be nice to get a 'nod' from a person who has the US-122L workin
on their system. But I do appreciate Clemens' help and guidance,
Simon.

--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
