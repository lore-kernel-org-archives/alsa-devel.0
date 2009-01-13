From: "Edwin van der Horst" <edwinvdh@gmail.com>
Subject: Recorded frames sign 'error' after switchign to EABI
	kernel?
Date: Tue, 13 Jan 2009 10:35:28 +0100
Message-ID: <faeb2d2e0901130135n4a5f557esfdf5743da0e00f11@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 83BD21037F1
	for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2009 10:35:28 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id 16so4286516fgg.44
	for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2009 01:35:28 -0800 (PST)
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

Hello all,

I'm using the ALSA API for quite some time now in my application,
all worked fine until I switched to EABI kernel/compiler.

My application reads signed 16 bit frames (S16_LE) using readi call:

long FCAudio::readRecordedPCM(char * dest,int len)
{
    ....
    frames  = snd_pcm_readi(recHandle, dest, (len / asRec.bytesPS));
//read data hw
     ....
     ....
}

This worked fine on the non EABi kernel.
After I switched to the EABI enabled kernel and compiler, I heard
massive 'hiss/noise' on recorded audio.
I took a dump of the recorded frames, and this came out:

sample data:
| ff |  58 |  ff | e1 | ff | e2 | 0 | 0 | 0 | 48 | ff | e0 | ff | e3 |
ff | e1 | 0 | 13 | ff | ca | ff | ae | 0 | 3 | ff | ee | ff | be|

at first this seemed like correct data to me , but on a closer look
the MSB(yte) is always 0x00 or 0xff
I can't figure out why this is: I'm expecting 2 bytes of sample data,
and in the current case I get 1 byte of correct data, and the other
byte is only used for sign indication (0x00 or 0xFF).

I can't figure out why this is, can anyone point me in the right direction?
It's worth noting that arecord and aplay both work correctly, and
using snd_pcm_dump(); I get settings as expedted and are correct.

Thanks in advance...

Edwin van der Horst
