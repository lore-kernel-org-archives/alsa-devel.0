From: Anthony <avan@uwm.edu>
Subject: envy24control
Date: Sun, 30 Nov 2003 02:03:44 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031130080344.GA22096@ice_nine.wi.rr.com>
Reply-To: avan@uwm.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi. The envy24control has undergone some significant
changes, most of which are good. But I no longer
understand how to set levels. It used to be that
111 on the on ADC level was -10Db and the top was 
+4db I think. Now there is a separate input gain.
I am completely unable to set the levels to reasonable
values on my delta44. Of course, I probably just
need to play around, but everything is either way
too hot or far too low. Before, things seemed perfectly
neutral. On my 1010 I don't have these sliders, which
makes sense because of the external buttons for selecting
levels. On that card the levels are perfect. I really
would rather just have a toggle button for the input gain.
I *think* this is how the windows interface works.

I'd be willing to patch it if I knew what values made
sense.

In addition the levels which feed channels into the 
digital mixer seem far too sensitive. A very small
change almost kills the signal. Perhaps these need
to be rescaled? 

Thanks for you time.

--ant


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
