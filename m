From: Erik de Castro Lopo <erikd-alsa@mega-nerd.com>
Subject: Re: alsa-0.9.3a : powermac locks machine hard
Date: Fri, 16 May 2003 07:36:29 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030516073629.350fd056.erikd-alsa@mega-nerd.com>
References: <20030515190540.567823bd.erikd-alsa@mega-nerd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030515190540.567823bd.erikd-alsa@mega-nerd.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 15 May 2003 19:05:40 +1000
Erik de Castro Lopo <erikd-alsa@mega-nerd.com> wrote:

> Hi all,
> 
> I have an Apple iBook running Debian Linux with a kernel compiled
> from the Debian kernel-source-2.4.20 package with the Debain PowerPC
> patches applied. I have installed from source (obtained at 
> alsa-project.org) :
> 
> 	alsa-driver-0.9.3a
> 	alsa-lib-0.9.3
> 
> When I run the init script ("/etc/init.d/alsa start" on my Debian 
> installation) it fails stating that alsactl seg faulted. If I 
> then run "/etc/init.d/alsa stop", the machine locks hard (no 
> response to keyboard or pings).
> 
> I then removed the battery and rebooted the machine. Here is the
> kernel Ooops message. Is there anything I can do to help debug this?

Can anyone tell me where to begin debuggung this?

Erik
-- 
+-----------------------------------------------------------+
  Erik de Castro Lopo  nospam@mega-nerd.com (Yes it's valid)
+-----------------------------------------------------------+
"Open source is an intellectual-property destroyer. I can't 
imagine something that could be worse than this for the software 
business and the intellectual-property business."
 -- Jim Allchin, Microsoft


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
