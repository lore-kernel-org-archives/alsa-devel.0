From: Florian Faber <faber@faberman.de>
Subject: Re: channel names
Date: Fri, 08 Feb 2013 08:07:47 +0100
Message-ID: <5114A443.5090004@faberman.de>
References: <51141B43.7070108@drcomp.erfurt.thur.de>
 <s5hbobv8fga.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from linuxproaudio.org (70.52.11.217.in-addr.arpa.manitu.net
 [217.11.52.70]) by alsa0.perex.cz (Postfix) with ESMTP id A7619265324
 for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2013 08:07:52 +0100 (CET)
In-Reply-To: <s5hbobv8fga.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/08/13 07:52, Takashi Iwai wrote:
> At Thu, 07 Feb 2013 22:23:15 +0100,
> Adrian Knoth wrote:
>>
>> Hi!
>>
>> Am I missing something or doesn't ALSA support channel names?
>>
>> When dealing with multichannel interfaces, it's pretty inconvenient to
>> remember whether channel 193 is on MADI 3, AES-EBU or phones.
>>
>> We can address this on the jackd level, however, since OSX allows audio
>> drivers to name their channels, I wonder how to do the same with ALSA?
> 
> It's possible to give some information via the new channel map API,
> but things like AES-EBU or phone aren't defined there.  We'd need new
> value definitions for such.

There might be interfaces that change the type of connection depending
on the current configuration (clock setting, pluggable hardware modules
etc.).

In the hdsp(m) and marian drivers I added ports.in and ports.out in
/proc which contain a list with the current physical port names. It is a
quick hack, but it works fine together with a patch for jack that
imports this list.


Flo
-- 
Machines can do the work, so people have time to think.
public key B3B9226C
