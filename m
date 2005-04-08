From: "Dominic Espinosa" <dcespin@fastmail.fm>
Subject: Perl interface to alsalib MIDI?
Date: Fri, 08 Apr 2005 02:33:08 -0700
Message-ID: <1112952788.6701.231408303@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hello,

I'm interested in developing a rather specialized MIDI application, and
I could use some advice. I'm a sound technician and I work with a Roland
VM-7200 virtual mixing system. For the sorts of things I need to do with
it in live performance, I would like to be able to control the mixer via
MIDI. This is possible, but only through SysEx messages which use the
Data Set/Data Transfer method outlined by Roland in the MIDI
implementation for the device. The mixer has a zillion controls, and the
implementation chart alone is some 10 pages of tiny font (to give you an
idea of how much texty stuff I would have to handle). What I want to do
is send a series of SysEx messages, set up in advance, according to
certain keypresses. So, for example, pressing one key might mute a
predefined set of mixer tracks, and pressing another key might change
the parameters of the onboard effects unit and increase the volume of 3
faders by some value. Since the only thing I'm doing is
remote-controlling a MIDI device by sending a bunch of SysEx's, an
ordinary sequencer program is unsuitable. 

As you can see, this will be pretty heavy in the string-manipulation
department, since several hundred control messages have to be defined,
and then the user has to be able to set up a config file which describes
sets of control messages to send. There is not really any timing
requirement, except that all the messages should be sent within 1 - 2
seconds, and the app has to wait for at least 20 ms between each one (to
accomodate the mixer's protocol).

My first thought was to use perl, since it would be a simple matter to
set up a big hash of the possible control messages and then select the
sets and parameter values according to the user's config file. However,
I have not been able to find any references to using perl with alsalib.
Before I leap into perl-XS-land and write my own interface, I thought I
would ask whether this is likely to work well in the first place. I have
not done much audio development and this approach may be misguided.
There are a few MIDI modules for perl, but none of them are quite what I
need and they all rely on the OSS interface anyway.

A second approach would be to write in C and use XML or Guile as the
configuration language, but it seems like this would involve a lot more
code and may not be as flexible -- if I'm going for interpreted
functionality anyway, it seems better to write the whole app in an
interpreted language in the first place if possible. A third thing is
that I noticed something called 'alsalisp' in the distro, but I have no
idea what it is and can't find any docs.

Any advice would be appreciated!

-- 
  Dominic Espinosa
  dcespin@fastmail.fm



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
