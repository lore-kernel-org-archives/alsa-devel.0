From: Colin Fletcher <colin.m.fletcher@googlemail.com>
Subject: Re: Can't connect to MIDI output of Edirol UA-1000
Date: Tue, 18 Sep 2012 16:14:48 +0100
Message-ID: <50588FE8.4070206@googlemail.com>
References: <50587F96.8080005@googlemail.com> <505883EA.6070808@ladisch.de>
 <5058898C.6020608@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 50E5D2625E2
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2012 17:13:30 +0200 (CEST)
Received: by wibhq4 with SMTP id hq4so3233530wib.2
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2012 08:13:30 -0700 (PDT)
In-Reply-To: <5058898C.6020608@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 18/09/12 15:47, Colin Fletcher wrote:
> On 18/09/12 15:23, Clemens Ladisch wrote:
>> Colin Fletcher wrote:
>>> I've just recently noticed that connections to the MIDI output
>>> of my Edirol UA-1000 fail when using the snd_ua101 driver in
>>> recent kernels.
>>> 
>>> aconnect simply reports "Connection failed (Input/output 
>>> error)"; a2jmidid -e says "ERROR: a2j_port_create: 
>>> snd_seq_connect_to() for 20:0 failed with error -5"
>> 
>> Are there any error messages in the system log?
>> 
> 
> Hi Clemens,
> 
> Not a squeak in/var/log/syslog or /var/log/messages when I try to 
> connect using aconnect, no. Can you think of anywhere else I might
> look?
> 
> Colin.

Just a little more info: 'strace aconnect 20:0 20:0' shows that the
SNDRV_SEQ_IOCTL_SUBSCRIBE_PORT ioctl on "/dev/snd/seq" is the thing
which is giving the EIO error.

Colin.
