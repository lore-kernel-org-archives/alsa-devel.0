Return-Path: <alsa-devel-bounces@alsa-project.org>
References: <3d5a5368f3a43ffc0114daf09c306d7e.squirrel@mungewell.org>
From: Clemens Ladisch <clemens@ladisch.de>
Message-ID: <570E0AE0.3020507@ladisch.de>
Date: Wed, 13 Apr 2016 11:01:20 +0200
MIME-Version: 1.0
In-Reply-To: <3d5a5368f3a43ffc0114daf09c306d7e.squirrel@mungewell.org>
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
Cc: alsa-devel@vger.kernel.org
List-ID: <alsa-devel@alsa-project.org>

Simon Wood wrote:
> I have been struggling for the past few days to get a Tascam US-122L (USB
> sound-card/midi interface) working, despite reading numerous forum
> postings I have only been able to get the midi portion working.

Does it show up with "aplay -l"?

> I note that the USB descriptor seems to be corrupt. It declares 2
> interfaces, but then describes 3 separate with the same interface number
> for the last 2.

The descriptors describe two alternate settings for the same interface.
This is a feature, which is required for audio devices.

>   iManufacturer           1 (error)				<------ Here be Errors!
>   iProduct                2 (error)
>   iSerial                 3 (error)

It's possible that lsusb does not have the permissions needed to send
the messages to ask for the strings.  Try running it as root.


Regards,
Clemens
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
