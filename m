From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Build-in mixer
Date: Mon, 13 Oct 2003 14:13:15 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0310131404550.18722-100000@studcom.urz.uni-halle.de>
References: <1065886408.3f8822c843535@webmail.zcu.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1065886408.3f8822c843535@webmail.zcu.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Daniel Tihelka <dtihelka@kky.zcu.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Daniel Tihelka wrote:
> [dmix]
> Aad what about streams with different sampling frequencies?

The dmix plugin always uses a fixed sample rate. The default is 48000,
but you can change it as follows:

pcm.!default {
	type plug
	slave.pcm {
		type dmix
		ipc_key 54042615
		ipc_key_add_uid yes
		slave {
			pcm "hw:0"
			rate 44100
		}
	}
}


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
