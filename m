From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Strange shadow process when using alsa and .asoundrc
 dsnoop
Date: Thu, 29 Sep 2005 09:28:52 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0509290927140.4137-100000@studcom.urz.uni-halle.de>
References: <535B7838-7AD2-4A84-9B3F-D84F7A2F4867@popwire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <535B7838-7AD2-4A84-9B3F-D84F7A2F4867@popwire.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Kenth Andersson <kenth@popwire.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Kenth Andersson wrote:
> I got a M-Audio Delta 44 with 4 mono inputs, I use the .asoundrc file
> to split this into four different sound devices (using dsnoop), one
> for each mono channel.
>
> When I connect my program to one of the devices (cline1-4) it works
> great, but if I run ps ax I can see that there are two instances of
> my program, each with the same command line, but different PID, one
> is my program but what is the other one?

The dmix/dsnoop plugins start another thread to do the mixing and to
communicate with each other program that shares the same device.

> Can this shadow process be prevented from starting?

Don't use dsnoop.  ;-)


HTH
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
