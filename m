From: Kenth Andersson <kenth@popwire.com>
Subject: Strange shadow process when using alsa and .asoundrc dsnoop
Date: Thu, 29 Sep 2005 08:24:21 +0200
Message-ID: <535B7838-7AD2-4A84-9B3F-D84F7A2F4867@popwire.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I got a M-Audio Delta 44 with 4 mono inputs, I use the .asoundrc file  
to split this into four different sound devices (using dsnoop), one  
for each mono channel. See .asoundrc below.

When I connect my program to one of the devices (cline1-4) it works  
great, but if I run ps ax I can see that there are two instances of  
my program, each with the same command line, but different PID, one  
is my program but what is the other one? If I kill this "shadow  
process" my program still works...

Does anybody know anything about this?
Can this shadow process be prevented from starting?

My .asoundrc:
#  
-----------------------------------------------------------------------
# Capture
pcm.capture {
     type dsnoop
     ipc_key 1024
     slave {
         pcm "hw:0"
         period_time 0
         period_size 1024
         buffer_size 4096
         channels 4
     }
     bindings {
         0 0
         1 1
         2 2
         3 3
     }
}

pcm.cline1 {
     type plug
     slave {
         pcm "capture"
         channels 4
     }
     ttable.0.0 1
}

pcm.cline2 {
     type plug
     slave {
         pcm "capture"
         channels 4
     }
     ttable.0.1 1
}
pcm.cline3 {
     type plug
     slave {
         pcm "capture"
         channels 4
     }
     ttable.0.2 1
}

pcm.cline4 {
     type plug
     slave {
         pcm "capture"
         channels 4
     }
     ttable.0.3 1
}
#  
-----------------------------------------------------------------------



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
