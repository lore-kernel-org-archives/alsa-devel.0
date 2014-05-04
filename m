From: Daniel Mack <daniel@zonque.org>
Subject: Re: arecord - bug with big file?
Date: Mon, 05 May 2014 01:04:45 +0200
Message-ID: <5366C78D.5040507@zonque.org>
References: <5366A35F.4040308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 675AB2608CF
 for <alsa-devel@alsa-project.org>; Mon,  5 May 2014 01:04:47 +0200 (CEST)
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
To: korgman <korgie@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 05/04/2014 10:30 PM, korgman wrote:
> Bugtracker is down ->
> https://bugtrack.alsa-project.org/alsa-bug
> from main page ->
> http://alsa-project.org
> 
> So, excuse my reporting here.
> 
> I can't record with arecord for long periods.
> 
> time arecord -f dat -D hw:0,0 | aplay
> Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
> Playing WAVE 'stdin' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
> 
> real	186m25.375s

What architecture (uname -a) and distribution is this? Was your libc and
alsa-lib compiled with LARGEFILE support?


Daniel
