From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Urgent question
Date: Mon, 09 Jan 2006 14:54:11 +0000
Message-ID: <43C27913.8040903@superbug.co.uk>
References: <0AEFDFCCEC85B24E8051B23293C2CB640F2506@MMMSTCAE1.muac.corp.eurocontrol.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <0AEFDFCCEC85B24E8051B23293C2CB640F2506@MMMSTCAE1.muac.corp.eurocontrol.int>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: PIVATY Bertrand <bertrand.pivaty@eurocontrol.int>
Cc: Martin Habets <errandir_news@mph.eclipse.co.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

PIVATY Bertrand wrote:

>Hello all,
>
>Thanks for your quick reaction.
>
>aplay and speaker produce the same good quality on both onboard and PCI
>sound cards.
>
>It is indeed for us obvious that the problem is coming from the audio
>software.
>
>But when checking the source code, I didn't see anything special, I mean
>they mainly use the ALSA api, and it is basically looks like the
>different ALSA tutorials that I've found.
>
>This is a software from one of our provider, and I know that the code
>was ported from SUN microsystem to Linux to meet our requirements, there
>are some statements with "ioctl" calls, do you think that this could be
>an issue, as it bypass the ALSA api?
>
>I know it seems vague, but I can try to send some part of the code with
>ALSA (I think this is not a big issue, the only thing is I don't know
>witch part could be interesting to send).
>  
>
Output from this would help me.
cat /proc/asound/cards

As speaker-test worked fine, the problem will be due to one of 2 things.
1) Buffer and Period size setting.
It would be very useful to see how your app decides on buffer and period 
sizes. ALSA is somewhat different from other sound APIs, in that it does 
not hide the hardware buffer size from the user. I.e. You can only set 
buffer and period sizes that the sound card can actually support in 
hardware. Some extra care is therefore needed when deciding on buffer 
size. If I could see your source code with regard to buffer and period 
sizes, I could tell if this was the problem.

2) Sample rate.
If the sound card hardware can only do 48000Hz, and your sound 
application works at 44100Hz, there are certain circumstances where 
sound quality will suffer.
Here, if I knew which sound cards you were using, and the sample rate 
your application was using, I could help here.

Note:
I general fix to both the above problems would be to use a hardware 
mixing sound card.
e.g. SB Audigy  (Not LS or SE)  or a SB Live (not 24bit version)

Would it be acceptable to specifiy the sound card to use? I doubt that 
Air traffic control simulators have a very wide audience.

If you are not able to specify the sound card, there are software ways 
out of all the problems described above.

James



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
