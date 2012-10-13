From: Daniel Mack <zonque@gmail.com>
Subject: Re: bit depth issue for Scarlett 2i4
Date: Sat, 13 Oct 2012 10:00:44 +0200
Message-ID: <50791FAC.6000408@gmail.com>
References: <CANOoOjtrGHCjtEjQ+6jAZ1un4pXsGD5=YyJV9F2mrUVbXpoO8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id A29662616BA
 for <alsa-devel@alsa-project.org>; Sat, 13 Oct 2012 10:00:48 +0200 (CEST)
Received: by mail-bk0-f51.google.com with SMTP id e19so1491896bku.38
 for <alsa-devel@alsa-project.org>; Sat, 13 Oct 2012 01:00:48 -0700 (PDT)
In-Reply-To: <CANOoOjtrGHCjtEjQ+6jAZ1un4pXsGD5=YyJV9F2mrUVbXpoO8w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan MacDonald <allcoms@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 13.10.2012 09:43, Dan MacDonald wrote:
> Hi ALSA devs!
> 
> I recently bought a Focusrite Scarlett 2i4 which is advertised as being
> capable of recording at a max of 24bit/96Khz but when I run alsacap it
> reports it as 32bit:
> 
> ./alsacap -R -d hw:1
> *** Exploring configuration space of device `hw:1' for recording ***
> 2 channels
> Sampling rate 44100..96000 Hz
> Sample formats: S32_LE
> Significant bits: 32
> 
> It does seem to record OK but that output seems wrong and I'm slightly
> concerned about the waste of disk space when multitracking if I end up with
> 32bit files but only 24 of those bits per sample are actually being used.

The output lets you know about the format the hardware uses on the wire.
Nothing to be concerned about - if you want to record 24 bits only, you
can use the plughw plugin to do the sample format conversion.


Daniel
