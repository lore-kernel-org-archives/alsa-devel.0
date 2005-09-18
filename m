From: Brad Midgley <bmidgley@xmission.com>
Subject: bluetooth/libalsa design
Date: Sat, 17 Sep 2005 22:56:09 -0600
Message-ID: <432CF369.9040700@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hi

Marcel Holtmann has done some investigation into making stereo/a2dp 
headsets available through libalsa. We've gone back and forth and 
decided that making a libalsa plugin is the best approach.

We've assumed the connection would be used by one app at a time and the 
bluetooth connection would be made on the audio device open call and 
closed after the audio device close call (with the possibility that the 
close is deferred in case the app immediately opens the audio device again).

Is it workable if instead, the bluetooth connection is brought up when 
the audio device is written to? We could close the connection when no 
writes have happened for a certain amount of time. Combined with an 
audio server of some sort, we could make an audio device that is 
available to all apps on the system and even more than one app at a time 
without burning out the headset's batteries during silence.

Does this approach sound workable? Which audio servers are appropriate 
in the middle there?

Brad


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
