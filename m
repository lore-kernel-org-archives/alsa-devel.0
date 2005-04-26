From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: How to tell how many frames gone to PCM
Date: Tue, 26 Apr 2005 16:16:14 -0400
Message-ID: <1114546574.8431.13.camel@mindpipe>
References: <426EA20A.70403@pianodisc.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <426EA20A.70403@pianodisc.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Steve deRosier <derosier@pianodisc.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2005-04-26 at 13:18 -0700, Steve deRosier wrote:
> All,
> 
> I'm having issues w/ synchronizing MIDI and audio data I output via Alsa.  I'm working through my program trying to confirm data flow and I need some help.
> 
> Is there a particular function (or other method) I can use to tell me the number of frames I have sent to alsa via snd_pcm_writei()?  

Just keep track of it yourself.  snd_pcm_writei() returns the number of
frames written on each call, so keep a running total.

Lee



-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
