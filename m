From: Ray Heasman <nurf@spamcop.net>
Subject: Re: Occasional metallic sound when recording (cs46xx)
Date: Thu, 23 Oct 2003 13:12:15 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1066939934.8767.119.camel@maze.mythral.org>
References: <20031022162219.GA29956@chapus.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031022162219.GA29956@chapus.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Eloy A. Paris" <peloy@chapus.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2003-10-22 at 09:22, Eloy A. Paris wrote:
> Hello,
> 
> I am trying to troubleshoot a very annoying problem I have with a Santa
> Cruz Turtle Beach (cs46xx). Sometimes, when recording, the recorded
> sound is very metallic. If when I get the metallic sound I run alsamixer
> and toggle the capture facility of the ADC on and off, sound is fixed
> and back to normal.
> 

My personal experience (not with ALSA, but other things) is that you can
get a horrid metallic sound when a signal is mixed with itself with a
small (a few samples) delay. So, this could be some sort of out by one
error causing the signal to get mixed with a delayed version of itself.

The other option that occurs to me is that perhaps there is a routing
problem with the signals - ie... an audio output is being "monitored"
and mixed back into the input. I have found it very easy to do this with
some applications with the ALSA drivers - they unintentionally produce
an output which gets mixed back into the input. The solution is to mute
all the stuff you don't want using alsamixer.

A good thing to try would be to set up GnomeMeeting on your alsa card.
It has a test mode that makes it easy to tell if you are getting an
unintentional loopback.

Hope this helps,
Ray




-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
