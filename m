From: "Jan \"Evil Twin\" Depner" <eviltwin69@cableone.net>
Subject: 0.9.0rc6 envy24control problem
Date: 23 Dec 2002 19:02:21 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1040691742.26027.27.camel@eviltwin>
Mime-Version: 1.0
Content-Type: text/plain
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


	I am running alsa 0.9.0rc6.  Apparently Jaroslav Kysela has made
changes to envy24control from rc5 allowing the user to set the internal
clock rate.  I am using a Hoontech ST Audio DSP24 card.  I have found
that in order to change the master clock setting I have to first switch
to S/PDIF In and then to another setting.  If I just switch between
settings (ie 44100 to 48000) the radio buttons change but the change is
not saved.  Obviously the workaround is to always switch to S/PDIF In
prior to switching to another mode but this is not an ideal situation. 
On trying to debug the code I found that changing to or from S/PDIF In
mode causes a call to control_input_callback which then calls
master_clock_update.  Merely calling master_clock_update from
internal_clock_set does not alleviate this problem.  Checking on the
reasons I have found that the call to snd_ctl_elem_read(ctl,
internal_clock) in master_clock_update resets the value returned by
snd_ctl_elem_value_get_enumerated(internal_clock, 0) to the previous
setting.  That is, if the enumerated value is 8 then a call to
internal_clock_set(int xrate) with xrate set to 9 will change the value
returned by snd_ctl_elem_value_get_enumerated(internal_clock, 0) to 9. 
A subsequent call to snd_ctl_elem_read(ctl, internal_clock) will cause
the value returned by snd_ctl_elem_value_get_enumerated(internal_clock,
0) to be 8.  To get down to brass tacks a call to snd_ctl_elem_read
immediately following a call to snd_ctl_elem_write seems to reset the
master clock value to what it was prior to the call to
snd_ctl_elem_write.

As I said, I have a workaround but I'm sure that someone with more
experience in this code (I just started an hour ago) would be able to
fix this one fairly quickly.  Sorry if the above is a bit confusing.

V/R
Jan Depner






-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
