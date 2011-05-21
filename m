From: "Luke-Jr" <luke@dashjr.org>
Subject: Re: Major 2.6.38 regression ignored?
Date: Sat, 21 May 2011 15:33:46 -0400
Message-ID: <201105211533.49082.luke@dashjr.org>
References: <201105201306.31204.luke@dashjr.org>
	<201105211123.56053.luke@dashjr.org>
	<aefc95$1usaq@orsmga001.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <aefc95$1usaq@orsmga001.jf.intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Chris Wilson <chris@chris-wilson.co.uk>
Cc: alsa-devel@alsa-project.org, Ray Lee <ray-lk@madrabbit.org>, intel-gfx@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, perex@perex.cz, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: alsa-devel@alsa-project.org

On Saturday, May 21, 2011 11:40:17 AM Chris Wilson wrote:
> The bisection is into an old DRI1 bug on 945GM. That DRI has inadequate
> locking between release and IRQ and so is prone to such races as befell
> Kirill should not surprise anyone. As neither UMS nor DRI supported SNB,
> I can quite confidently state they are separate bugs.

Unfortunately, I cannot help troubleshoot that bug any further, as I no longer 
have the affected motherboard. I was unable to reproduce it on my Intel 
DQ67SW.

However, I did encounter a new regression, which I have reported as:
	https://bugzilla.kernel.org/show_bug.cgi?id=35552
This one is related to Intel HD Audio, not Graphics.
