From: Michael Cree <mcree@orcon.net.nz>
Subject: Re: [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
Date: Mon, 31 Mar 2008 10:17:41 +1300
Message-ID: <AC20DA6E-C360-4F63-8C46-65E488475CDB@orcon.net.nz>
References: <20080329064227.58074DBA2@gherkin.frus.com>
	<47EE317E.9030807@keyaccess.nl>
	<20080330161400.GA24443@jurassic.park.msu.ru>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.orcon.net.nz (mx2.orcon.net.nz [219.88.242.52])
	by alsa0.perex.cz (Postfix) with ESMTP id DB94A2465E
	for <alsa-devel@alsa-project.org>;
	Sun, 30 Mar 2008 23:18:17 +0200 (CEST)
Received: from Debian-exim by mx2.orcon.net.nz with local (Exim 4.67)
	(envelope-from <mcree@orcon.net.nz>) id 1Jg4up-0005WP-6v
	for alsa-devel@alsa-project.org; Mon, 31 Mar 2008 10:18:12 +1300
In-Reply-To: <20080330161400.GA24443@jurassic.park.msu.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Krzysztof Helt <krzysztof.h1@wp.pl>, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Bob Tracy <rct@frus.com>, Tyson Whitehead <twhitehe@uwo.ca>
List-Id: alsa-devel@alsa-project.org

On 31/03/2008, at 5:14 AM, Ivan Kokshaysky wrote:

> On Sat, Mar 29, 2008 at 01:09:34PM +0100, Rene Herman wrote:
>> Okay. The thing that "fixed" Tyson was disabling mmap from the  
>> driver:
>>
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2008-March/006911.html
>
> Weird - I was sure the mmap problem has been fixed, but obviously
> the patch didn't go in...
>
> Andrew, could you please queue this up for 2.6.26?

I have applied the patch against the 2.6.24.3 kernel, and now have  
working sound on the newer PWS600au with mmap enabled alsa.  Verified  
through the on board ESS1887 and via the M-Audio Revolution 7.1 sound  
card.  (Ran out of time to also try the C-Media sound card.  Also ran  
out of time to try it out on the other alphas I have.)

The problem with the repeated sound bits playing at the end of certain  
sound files via the ESS1887 remains.

Michael.
