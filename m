From: Steve deRosier <derosier@pianodisc.com>
Subject: Re: How to tell how many frames gone to PCM
Date: Tue, 26 Apr 2005 14:07:51 -0700
Message-ID: <426EADA7.4090200@pianodisc.com>
References: <426EA20A.70403@pianodisc.com> <1114546574.8431.13.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1114546574.8431.13.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Yeah, already doing that.  I was hoping there was something else I could use to confirm the numbers I'm getting.

Here's the problem...

In order to get my MIDI and audio to sync up, I found about 1.5 years ago I had to add +4 to my sample count per PERIOD_SIZE number of samples I sent to the PCM.  I calculate my midi out time via the number of samples I've sent to the PCM.  I never could account for the discrepancy, and eventually settled for the hack (with a big fat comment in the code and a bug note in our bugzilla) in order to get our first software version shipped.  As you might imagine, this has come back to haunt me periodically as we continue to maintain the software.  It could be I NEED to do what I do in the hack do to something I'm not realizing, but it bothers me when I've got to do something I don't understand and is not supported by the assumptions in the system.  It could be something I'm doing weird (say an off by one bug in the code), or that I'm not using alsa right, but I've not been able to find it.

Now I'm against the wall and I've got to solve the problem (or at least understand why I have to do what I'm doing).  

Using the return value seems to report the expected number of frames as what I sent.  Frankly I was hoping that I'm not sending the expected number of frames to the PCM, figuring that it would give me a string to pull on.

Any more ideas would be great.

Thanks,
- Steve

Lee Revell wrote:
> On Tue, 2005-04-26 at 13:18 -0700, Steve deRosier wrote:
> 
>> All,
>> 
>> I'm having issues w/ synchronizing MIDI and audio data I output via
>> Alsa.  I'm working through my program trying to confirm data flow
>> and I need some help.
>> 
>> Is there a particular function (or other method) I can use to tell
>> me the number of frames I have sent to alsa via snd_pcm_writei()?
>> 
> 
> 
> Just keep track of it yourself.  snd_pcm_writei() returns the number
> of frames written on each call, so keep a running total.
> 
> Lee
> 


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
