From: Roman Haefeli <reduzent@gmail.com>
Subject: Re: hdsp rpm support
Date: Mon, 01 Oct 2012 22:00:56 +0200
Message-ID: <1349121656.2263.3.camel@yoyo5>
References: <1326877559.24738.84.camel@yoyo4>
 <20120118102658.GA5351@linuxaudio.org> <1349046242.2195.6.camel@yoyo5>
 <50694EB0.8060700@faberman.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 23790260728
 for <alsa-devel@alsa-project.org>; Mon,  1 Oct 2012 22:01:00 +0200 (CEST)
Received: by bkue19 with SMTP id e19so4175720bku.38
 for <alsa-devel@alsa-project.org>; Mon, 01 Oct 2012 13:00:59 -0700 (PDT)
In-Reply-To: <50694EB0.8060700@faberman.de>
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

On Mon, 2012-10-01 at 10:05 +0200, Florian Faber wrote:
> On 10/01/12 01:04, Roman Haefeli wrote:
> 
> >> AFAICS, the problem is with the code that identifies the card
> >> as an RPM, Multiface or Digiface, and that triggers ths HW into
> >> accepting the firmware. Once past this point everything works
> >> perfectly, including switching the phone preamps etc.
> > How are you able to switch the phone preamps? Even in the git version of
> > hdspconf, there is no mentioning of the RPM at all. To me it looks there
> > isn't any support at all in hdspconf for HDSP RPM. Do you have some
> > unofficial version of hdspconf that _does_ support the RPM?
> 
> Use alsamixer.

That is great. Thanks for the tip.

The switches for buffer size and sr don't seem to be working. However, I
seem to be able to set those from jackd. I don't get all advertised (by
RME) sampling rates, though: 32k, 44.1k, 48k work, 88.2k and 96k do not
(it silently fails back to 48k). 

Roman
