From: Florian Faber <faber@faberman.de>
Subject: Re: hdsp rpm support
Date: Mon, 01 Oct 2012 10:05:04 +0200
Message-ID: <50694EB0.8060700@faberman.de>
References: <1326877559.24738.84.camel@yoyo4>
 <20120118102658.GA5351@linuxaudio.org> <1349046242.2195.6.camel@yoyo5>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from linuxproaudio.org (70.52.11.217.in-addr.arpa.manitu.net
 [217.11.52.70]) by alsa0.perex.cz (Postfix) with ESMTP id 4C2092616F2
 for <alsa-devel@alsa-project.org>; Mon,  1 Oct 2012 10:05:06 +0200 (CEST)
In-Reply-To: <1349046242.2195.6.camel@yoyo5>
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

On 10/01/12 01:04, Roman Haefeli wrote:

>> AFAICS, the problem is with the code that identifies the card
>> as an RPM, Multiface or Digiface, and that triggers ths HW into
>> accepting the firmware. Once past this point everything works
>> perfectly, including switching the phone preamps etc.
> How are you able to switch the phone preamps? Even in the git version of
> hdspconf, there is no mentioning of the RPM at all. To me it looks there
> isn't any support at all in hdspconf for HDSP RPM. Do you have some
> unofficial version of hdspconf that _does_ support the RPM?

Use alsamixer.


Flo
-- 
Machines can do the work, so people have time to think.
public key B3B9226C          x-hkp://wwwkeys.eu.pgp.net
