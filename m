From: "Ivica Bukvic" <ico@fuse.net>
Subject: Alsa /dev/sequencer stuff
Date: Tue, 20 May 2003 00:15:19 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000201c31e86$6cacf0f0$ac1f830a@ICO>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
Cc: alsa-user@lists.sourceforge.net, linux-audio-dev@music.columbia.edu
List-Id: alsa-devel@alsa-project.org

Hi all, I was wondering the following:

In my app (RTMix) I will be soon implementing multiple midi-input device
opens, so that the app can be controlled from as many of the midi
controllers simultaneously as possible. One way of devising this was to
design a separate thread for every open device (using raw midi /dev/midi
etc., although I will be re-implementing that to use ALSA devices
directly). However, this might not be the most elegant way of doing
this, so what I was wondering is how does the /dev/sequencer correspond
to this issue? I mean, does it work the same way like addressing the raw
midi ports, are the message formats the same, and most importantly does
one SINGULAR /dev/sequencer encompass all of the midi ports that are
currently available?

I would greatly appreciate any help on this issue, as well as some code
examples. Thank you! Sincerely,

Ivica Ico Bukvic, composer & multimedia sculptor
http://meowing.ccm.uc.edu/~ico




-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
