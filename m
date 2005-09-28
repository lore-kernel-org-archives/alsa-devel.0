From: Richard Jones <bob@the800group.com>
Subject: Back to basics
Date: Wed, 28 Sep 2005 23:44:44 +0100
Message-ID: <433B1CDC.2090201@the800group.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi all

I have what I am hoping is a very basic question and the answer will 
help me better understand ALSA and how it works.

What I want to do is write a simple program that lists the available 
midi devices currently connected to my machine and I can then choose one 
and capture the input from that midi device.

I think it best to break it down into the components

1. I connect my Yamaha keyboard to my laptop and it is assigned to one 
of the midi devices in /dev/snd/midi????. Is there a way with ALSA to 
list the devices that are currently valid or a way of working it out in 
a program. I have seen "pmidi -l" but that gives me a list of ports that 
I don't know how to relate back to the device names in /dev/snd. 
Similarly, rawmidi requires me to know which device has been allocated 
to my keyboard. I have seen music applications using ALSA that produce a 
pull down list of valid devices to choose from. How do they work that out?

2. I want to read the midi stream coming in from the piano and just 
translate it into its relative note value - middle C. (using the ALSA API)

So, ignoring all error handling and other programming "stuff", could 
someone please write down the most basic piece of C code where the ALSA 
API is being used to achieve these two things?

Thanks
Bob



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
