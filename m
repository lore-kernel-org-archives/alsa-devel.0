From: Colin Fletcher <colin.m.fletcher@googlemail.com>
Subject: Re: Can't connect to MIDI output of Edirol UA-1000
Date: Tue, 18 Sep 2012 15:47:40 +0100
Message-ID: <5058898C.6020608@googlemail.com>
References: <50587F96.8080005@googlemail.com> <505883EA.6070808@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 by alsa0.perex.cz (Postfix) with ESMTP id ABE78264FFA
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2012 16:46:22 +0200 (CEST)
Received: by weyx10 with SMTP id x10so4316582wey.38
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2012 07:46:22 -0700 (PDT)
In-Reply-To: <505883EA.6070808@ladisch.de>
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

On 18/09/12 15:23, Clemens Ladisch wrote:
> Colin Fletcher wrote:
>> I've just recently noticed that connections to the MIDI output of
>> my Edirol UA-1000 fail when using the snd_ua101 driver in recent
>> kernels.
>> 
>> aconnect simply reports "Connection failed (Input/output
>> error)"; a2jmidid -e says "ERROR: a2j_port_create:
>> snd_seq_connect_to() for 20:0 failed with error -5"
> 
> Are there any error messages in the system log?
> 

Hi Clemens,

Not a squeak in/var/log/syslog or /var/log/messages when I try to
connect using aconnect, no. Can you think of anywhere else I might look?

Colin.
