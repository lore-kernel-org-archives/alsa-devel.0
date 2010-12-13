From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: 10 Sec sleep in wait_for_avail_min function
Date: Mon, 13 Dec 2010 10:07:01 +0100
Message-ID: <4D05E235.1040100@ladisch.de>
References: <AANLkTim1729oJUmPvOkMGjBBKjb-BnnsWADPx1r3MmZ3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <AANLkTim1729oJUmPvOkMGjBBKjb-BnnsWADPx1r3MmZ3@mail.gmail.com>
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
Cc: alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Nitin Arora wrote:
> I need to stream audio from my audio device to the host through USB.
> While audio is being streamed and songs are being played on the host
> and during that I plug out the audio device, Disconnect event takes
> too long to get reported and displayed on the screen (on GUI).
> 
> I dug this problem a little deeper and found that when my application is
> continuous invoking read on the audio device to capture and audio data
> it follows this path:
> 
> .... .. snd_pcm_lib_read -> snd_pcm_lib_read1 -> snd_pcm_capture_avail
> 
> and in the case when there is no data left (MY DISCONNECT CASE)
> it invokes as follows:
> 
> .... .. snd_pcm_lib_read -> snd_pcm_lib_read1 -> wait_for_avail_min
> 
> and in wait_for_avail_min it sleeps for 10 sec.

This ten-second timeout is intended for devices where the interrupt does
not work for some reason.

In the case of USB disconnection, the driver should stop the stream
immediately.  Does this happen if you try to record with the arecord
tool?


Regards,
Clemens
