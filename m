From: Bob Ham <rah@bash.sh>
Subject: pcm_jack and jack chicken-and-egg situation
Date: 05 Mar 2003 00:02:30 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1046822550.8620.193.camel@insanity.tek.net>
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

Hi all,

The new pcm_jack thing presents a bit of a chicken and egg problem; I
just compiled alsa-lib twice because jack depends on alsa-lib and if you
configure alsa-lib with jack support, it depends on jack.  Would it be
possible for pcm_jack to be distributed seperately?

Cheers,

Bob

-- 
Bob Ham <rah@bash.sh>



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
