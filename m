From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: what is trigger time?
Date: Fri, 08 Oct 2004 00:08:47 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1097208527.9372.50.camel@krustophenia.net>
References: <Pine.LNX.4.58.0410071801160.18124@concorde.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0410071801160.18124@concorde.cs.ucla.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Hanbiao Wang <hbwang@lecs.cs.ucla.edu>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2004-10-07 at 21:07, Hanbiao Wang wrote:
> Hi, All
>     According to the ALSA documentation, the following two functions
> snd_pcm_status_get_trigger_tstamp()
> snd_pcm_status_get_trigger_htstamp()
> are suppose to get the "trigger time". However, I can not find any
> documents that explains or define the meaning of the "trigger time".
> Is that the time when a whole period of samples in the buffer is ready to
> be read in? Could somebody please give me a hint? Thanks a lot.
> 

I don't have the source in front of me but I would expect this to be the
time when the ALSA middle layer executed the trigger callback.  This
happens when a PCM is stopped, started, or paused.

Lee



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
