From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: arecord - bug with big file?
Date: Mon, 05 May 2014 11:46:54 +0200
Message-ID: <53675E0E.2060303@ladisch.de>
References: <5366A35F.4040308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id B9F80261B14
 for <alsa-devel@alsa-project.org>; Mon,  5 May 2014 11:46:55 +0200 (CEST)
In-Reply-To: <5366A35F.4040308@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: korgman <korgie@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

korgman wrote:
> I can't record with arecord for long periods.
>
> time arecord -f dat -D hw:0,0 | aplay
> Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
> Playing WAVE 'stdin' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
>
> real    186m25.375s

This is the time needed for 2^31 bytes.  Stopping recording after that
is a feature because .wav files (as supported by arecord) have a 2 GB
limit.  When recording to a file, it would be possible to create
multiple files, but this is not possible with stdout.

Use "-t raw" to avoid the .wav restrictions.  (This requires you to
tell aplay about the format.)


Regards,
Clemens
