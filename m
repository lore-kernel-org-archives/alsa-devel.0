From: Manuel Jander <manuel.jander@mat.utfsm.cl>
Subject: Multiple drivers. help
Date: Mon, 21 Apr 2003 22:41:15 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EA4ABCB.1040603@mat.utfsm.cl>
Reply-To: manuel.jander@mat.utfsm.cl
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

Hi,


With the current Aureal Driver we have the following dilema:
We support 3 soundcards: the AU8810, AU8820 and AU8830.
They are very similar to each other and share a lot of code (almost 
all). But they use different register address offsets and "sizes" of 
some resources.
So we have one .c file and one .h file for each card. All that in one
directory which is pci/au88x0/. How do I make it to compile on or 
another driver ?

The configure script story is allready OK. selscting the different
drivers triggers different CONFIG_SND_XXXXX environment variables to 
appear in the makefiles,
but :
how can that info be transmitted to header file #ifdef's ?
The corresponding CONFIG_SND_AU8810, CONFIG_SND_AU8820 and
CONFIG_SND_AU8830 defines of the Makefile's aren't recognized inside
any header file.

Any clue would be helpful.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
