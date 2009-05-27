From: Timur Tabi <timur@freescale.com>
Subject: Re: [alsa-devel] [PATCH] Modify mpc5200 AC97 driver to use V9 of
	spin_event_timeout()
Date: Tue, 26 May 2009 19:53:24 -0500
Message-ID: <ed82fe3e0905261753v1cb9c901i3b66cd903e4adda6@mail.gmail.com>
References: <20090527002530.16740.62502.stgit@terra>
	<ed82fe3e0905261738u655f6f5at2351341a0a5e50d5@mail.gmail.com>
	<9e4733910905261744j3589ace8wd427ef8a5998eccf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org>
In-Reply-To: <9e4733910905261744j3589ace8wd427ef8a5998eccf@mail.gmail.com>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

On Tue, May 26, 2009 at 7:44 PM, Jon Smirl <jonsmirl@gmail.com> wrote:

> Because Grant didn't want me doing udelay(50) just to delay things in
> order to give the AC97 controller time to initialize. Your function
> lets me loop on cpu_relax() for 50us.

But udelay() calls HMT_low(), which is like cpu_relax().

-- 
Timur Tabi
Linux kernel developer at Freescale
