From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.12-rc5-mm1
Date: Fri, 27 May 2005 22:32:13 +0000
Message-ID: <1117233133l.7104l.0l@werewolf.able.es>
References: <200505271738.j4RHcqg04138@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262631AbVE0Wdu@vger.kernel.org>
In-Reply-To: <200505271738.j4RHcqg04138@unix-os.sc.intel.com> (from
	kenneth.w.chen@intel.com on Fri May 27 19:38:52 2005)
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Rafael J. Wysocki'" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>, tomlins@cam.org, linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 05.27, Chen, Kenneth W wrote:
> Rafael J. Wysocki wrote on Friday, May 27, 2005 3:29 AM
> > > I assume the problem is due to one of the ASLA patches in rc5-mm1, but it's
> > > possible that it lies elsewhere.
> > 
> > Well, yes.  Apparently, it goes away if you revert the following patch:
> > 
> > avoiding-mmap-fragmentation-fix-2.patch
> 
> 
> avoiding-mmap-fragmentation-fix-2.patch has a major clash using
> vm_private_data where alsa is also using.  I just posted a patch,
> please try that out.  Thanks.
> 
> http://marc.theaimsgroup.com/?l=linux-mm&m=111721191501940&w=2
> 

This makes my oopses go away in beep-media-player.
Thanks!

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.11-jam20 (gcc 4.0.0 (4.0.0-3mdk for Mandriva Linux release 2006.0))
