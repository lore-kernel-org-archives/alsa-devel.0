From: Laurent Georget <lgeorget2@club-internet.fr>
Subject: Pb with new alsa cvs, level plugin and low buffer size
Date: Thu, 20 Feb 2003 23:15:50 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E555396.1090106@club-internet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Hi!

After checking out cvs yesterday , I have now errors when running level
plugin from Abramo Bagnara
or ameter plugin ( which is here:
http://perso.club-internet.fr/lgeorget/ameter.html
) ,  when buffer size is low:

aplay -D ameter -B 5000 -v glametest.wav

...
aplay: pcm_write:1014: write error: Input/output error



aplay -D level -B 5000 -v glametest.wav

...
aplay: pcm_write:1014: write error: Input/output error


(No error when running aplay with a normal buffer size and level plugin
, or with low buffer size and no level plugin)


- In the same way, using Glame with ameter and a low buffer size fails
(this is bad because this prevents to
make multitracks recording)

- Installing 0.9rc7 solves the problem

- I use Mandrake 9 and ens1371 driver.

Any idea?
Best regards ,

Laurent







-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
