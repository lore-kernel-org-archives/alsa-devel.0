From: "Eliot Blennerhassett" <bigblen@icqmail.com>
Subject: Driver development: Mixer control naming
Date: Tue, 13 May 2003 01:10:17 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030513011018.11517.h003.c012.wm@mail.icqmail.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
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

Hello,

Say I have a card with 4 playback streams each with its
own volume control.

Each stream can be mixed to any of 4 lineouts.
(I.e. a matrix mixer with total 16 controls)

Each lineout has a level setting (i.e. a volume control)

How should I name these controls for snd_ctl_add()
What if anything should I base the .index on?
Particularly for the matrix mixer.

I have tried creating say four "Master Volume" controls
with index=0,1,2,3. But I get an error from amixer
about duplicate controls.  I have resorted to combining
the indices with the name string in the mean time, and
using a unique .index for every control.

regards

Eliot Blennerhassett
AudioScience Inc.



-------------------------------------------------------------
Sign up for ICQmail at http://www.icq.com/icqmail/signup.html


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
