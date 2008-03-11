From: rct@frus.com (Bob Tracy)
Subject: Re: [alsa-devel] [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
Date: Tue, 11 Mar 2008 15:34:21 -0500 (CDT)
Message-ID: <20080311203421.BBEFDDBA2@gherkin.frus.com>
References: <ED0F0070-B876-4D8B-8F88-879E01AB4326@orcon.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <ED0F0070-B876-4D8B-8F88-879E01AB4326@orcon.net.nz>
 "from Michael Cree at Mar 12, 2008 09:00:13 am"
Sender: linux-alpha-owner@vger.kernel.org
To: Michael Cree <mcree@orcon.net.nz>
Cc: Bob Tracy <rct@frus.com>, Rene Herman <rene.herman@keyaccess.nl>, Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>, linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org, Krzysztof Helt <krzysztof.h1@wp.pl>
List-Id: alsa-devel@alsa-project.org

Michael Cree wrote:
> Yes, the ESS1888 driver failed to work on Alpha about the 2.6.14 to  
> 2.6.16 kernel.   It came right with alsa release 1.0.13 (IIRC) and I  
> have been running the ESS1888 driver on an Alpha XP1000 without  
> problems for about a year.

Nod.  I take it things were working for you at least as recently as
2.6.22, then.  I can try that version and see if it works for me.  My
situation is that I can't swear I've tried anything involving ALSA on
the Alpha since 2.6.16 until recently, so I'm not sure this is really a
regression in my case.

Because I threatened to do it :-), I built a 2.6.25-rc4+iommu_patch
kernel with both the snd-es18xx and snd-sb8 modules available.  As
hoped (expected?), the snd-sb8 driver works fine.  This would imply
the problem is at least somewhat specific to the es18xx driver, and
that the underlying ALSA infrastructure is reasonably healthy (notice
that I intentionally avoided saying it was "sound" -- sorry, I never
could pass on low-hanging fruit).

-- 
------------------------------------------------------------------------
Bob Tracy          |  "I was a beta tester for dirt.  They never did
rct@frus.com       |   get all the bugs out." - Steve McGrew on /.
------------------------------------------------------------------------
