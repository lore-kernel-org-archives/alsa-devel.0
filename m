From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Code snippet issue
Date: Mon, 13 Oct 2003 14:34:33 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0310131429570.21012-100000@studcom.urz.uni-halle.de>
References: <20031013002738.IKV21559.tomts28-srv.bellnexxia.net@sympatico.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20031013002738.IKV21559.tomts28-srv.bellnexxia.net@sympatico.ca>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: jacqueslen@sympatico.ca
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

jacqueslen@sympatico.ca wrote:

> http://www.suse.de/~mana/seqdemo.c
> However, I've been unable to get it to work. It compiles, but
> running it doesn't do anything even when I send midi input from my
> keyboard. It simply blocks.

This test program simply creates a port, and prints the events sent to
this port. If you want to see anything, you have to connect another
port to the sample's port. See "aconnect -i" and "aconnect -o" for a
list of input and output ports, respectively. You can connect two
ports with, e.g., "aconnect 64:0 128:0".

A real program would be able to create a connection by itself (see
snd_seq_connect_from/to).


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
