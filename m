From: Max <amx192@gmail.com>
Subject: Re: alsa/asoundlib.h file not found
Date: Wed, 4 Dec 2013 18:38:42 +0000 (UTC)
Message-ID: <loom.20131204T193556-311@post.gmane.org>
References: <CAODvfaHhEHp5aYQ2CkeLTZvOVLP+8Ncq8VCpDtOeTPE4N0Fg8Q@mail.gmail.com>
 <4E65F701.9070304@ladisch.de>
 <CAPbw_hzv7z7jcHe-XaLAwmXevk9K154DiKUKEVVktDFRNRVeMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D735264FB0
 for <alsa-devel@alsa-project.org>; Thu,  5 Dec 2013 00:05:07 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1VoLV9-0002KU-VN
 for alsa-devel@alsa-project.org; Thu, 05 Dec 2013 00:05:04 +0100
Received: from 216.31.219.19 ([216.31.219.19])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Thu, 05 Dec 2013 00:05:03 +0100
Received: from amx192 by 216.31.219.19 with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Thu, 05 Dec 2013 00:05:03 +0100
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

Gabriel Beddingfield <gabrbedd <at> gmail.com> writes:

> 
> On Tue, Sep 6, 2011 at 5:33 AM, Clemens Ladisch <clemens <at> ladisch.de> 
wrote:
> > Appalayagari Sreedhar wrote:
> >> main.c:2:23: error: asoundlib.h: No such file or directory
> >
> > This means that alsa-lib is not installed correctly.
> 
> On Debian/Ubuntu, install a package called libasound2-dev
> On SuSe, you can probably `zypper install -C 'pkgconfig(alsa)'` (I
> think the -C is correct... for "capabilities")
> On Fedora, it's `yum install 'pkgconfig(alsa)'`
> 
> -gabriel
> 


I am still getting the problem even though alsa-lib-devel is installed on my 
fedora 14.
