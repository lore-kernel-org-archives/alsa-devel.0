From: Lee Revell <rlrevell@joe-job.com>
Subject: io_remap_page_range (was Re: [Alsa-devel] alsa-driver will not
	compile with kernel  2.6.9-rc2-mm4-S7)
Date: Fri, 01 Oct 2004 20:51:08 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1096678268.27818.84.camel@krustophenia.net>
References: <1096675930.27818.74.camel@krustophenia.net>
	 <32868.192.168.1.8.1096677269.squirrel@192.168.1.8>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S266914AbUJBAvQ@vger.kernel.org>
In-Reply-To: <32868.192.168.1.8.1096677269.squirrel@192.168.1.8>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2004-10-01 at 20:34, Rui Nuno Capela wrote:
> Lee Revell wrote:
> Good grief! I'm having this too, and I was desperate thinking I was the
> only one, and ultimately offering the blame to gcc 3.4.1 which is what I'm
> test-driving now on my laptop (Mdk 10.1c).
> 
> Now I remember that -mm4 has some issue about remap_page_range kernel
> symbol being renamed to something else, which is breaking the build of
> outsider modules (i.e. not the ones bundled under the kernel source tree).
> Or so it seems.

Looking through my archives I cannot find a report of this exact issue,
but you are probably right.  Looks like ALSA drivers need to be updated.

Lee
