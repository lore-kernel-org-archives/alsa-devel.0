From: Garett Shulman <shulmang@colorado.edu>
Subject: ice1712 dshare asoundrc config problem
Date: Thu, 20 Nov 2003 07:40:16 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FBCD250.7030308@colorado.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello, I am having three particular issues that I was hopeing someone 
might have some insight into. I have an ice1712 card and would like to 
be able to have the digital mixer mix xmms & fluidsynth so I can jam 
with mp3s. Here is the asoundrc I have created so far:

pcm.44_1 {
     type dshare
     ipc_key 10242
     slave {
         pcm "hw:0,0"
         period_size 64
         periods 16
     }
     bindings {
         0 0
         1 1
     }
}

pcm.44_1p {
     type plug
     slave {
         pcm 44_1
     }
}

pcm.44_2 {
     type dshare
     ipc_key 10245
     slave {
         pcm "hw:0,0"
     }
     bindings {
         0 2
         1 3
     }
}

pcm.44_2p {
     type plug
     slave {
         pcm 44_2
     }
}

The first issue is that fluidsynth will only output S16_LE format. This 
is why I have 44_1p & 44_2p. Is this the best way to get from hw:0,0 
which is S32_LE to S16_LE?

The second issue is that I cannot open more than one of the dshare 
devices. If 44_1p is opened by fluidsynth and I try and open 44_2 or 
44_2p I get an error that the device is already opened. Am I 
missunderstood that the point of dshare is so you can have different 
applications open different channels of a digital mixer? Or, am I using 
it incorrectly in the asoundrc?

The third issue is that even though I specify period_size 64 and periods 
16 in 44_1, fluidsynth still complains that it got a period_size of 3009 
and a periods of 2. I believe that the period_size of 3009 is causing 
serious latency.

I would really appreciate any suggestions that anyone might have. If you 
have any ideas, please take a moment to let me know. If I can get this 
working I will take some time and post info to the ice1712 wiki. Thanks. 
-Garett



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
