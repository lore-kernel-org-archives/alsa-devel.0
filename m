From: "Anandhi  Dhanabalan" <anandhid@rediffmail.com>
Subject: AC'97 compliant codec - query
Date: 7 May 2002 13:30:10 -0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020507133010.20306.qmail@webmail12.rediffmail.com>
Reply-To: "Anandhi  Dhanabalan" <anandhid@rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

I am a new to Audio driver development. I am currently developing 
a driver for Crystal Audio codec CS4205.

The datasheet of CS4205 defines serial data format for input and 
output data.
1) I'd like to know how the driver will identify the start of such 
frame?  Will any interupts be generated during each such frame 
start and fram end ?
2) If i want to write some data to Audio Codec register, the 
datasheet says, slot 1 should contain the register index & slot 2 
the data to be written.
 From the audio driver perspective is it enough if write is issued 
to the correponding port,
like WRITE_PORT(PCIBaseAddr+RegOffset, RegValue)
or do i need to manipulate the slots ? , if Yes how ?


Please bear with me if my question sounds silly.
Thanx in advance
- Anandhi


_________________________________________________________
Click below to visit monsterindia.com and review jobs in India or 
Abroad
http://monsterindia.rediff.com/jobs


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
