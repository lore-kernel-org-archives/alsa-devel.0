From: Steve deRosier <derosier@pianodisc.com>
Subject: How to get pcm buffer ptr info
Date: Tue, 22 Jun 2004 15:35:51 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40D8B447.6000602@pianodisc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I'm trying to take a look at the pcm buffer ptr info as printed from:
# cat /proc/asound/card0/pcm0p/sub0/status

state: RUNNING
trigger_time: 1087934998.775591000
tstamp      : 1087935198.156038000
delay       : 16013
avail       : 371
avail_max   : 2048
-----
hw_ptr      : 8794483
appl_ptr    : 8810496

snd_pcm_status_dump() call gives me the first part, but I'd like to get the hw_ptr and appl_ptr portion for debugging output from my program.

Before you go into "you don't need that information" mode, actually I do.  I don't have any interest in using it for anything other than display purposes, but I'm trying to confirm that the number of samples I think my application is writing to alsa actually matches the number of samples that alsa recieved.  So I want to do a call before I send any samples, and then right before I quit, look at the delta and see that it matches the expected ammount.  If there's another way to do this, I'd be happy to know about it.  Unfortuantely, just cat on status before and after I run my program just tells me the state is closed and not the last used ptrs.  

Anyone know how to tickle alsa-lib to tell me what I want to know?

- Steve


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
