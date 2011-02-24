From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 2/6] hdspmixer: Update FSF address.
Date: Thu, 24 Feb 2011 21:33:27 +0100
Message-ID: <1298579611-16573-3-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1298579611-16573-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1298579611-16573-1-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The FSF has moved, so reflect this change in the about dialogue.

See also http://www.fsf.org/about/contact/

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdspmixer/src/HDSPMixerAboutText.cxx b/hdspmixer/src/HDSPMixerAboutText.cxx
index 40bd862..c8c9b1a 100644
--- a/hdspmixer/src/HDSPMixerAboutText.cxx
+++ b/hdspmixer/src/HDSPMixerAboutText.cxx
@@ -41,8 +41,9 @@ HDSPMixerAboutText::HDSPMixerAboutText(int x, int y, int w, int h):Fl_Widget(x,
 	       "MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.\n"
 	       "See the GNU General Public License for more details.\n\n"
 	       "You should have received a copy of the GNU General Public License\n"
-	       "along with this program; if not, write to the Free Software\n"
-	       "Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.\n";
+	       "along with this program; if not, write to the\n"
+	       "Free Software Foundation, Inc., 51 Franklin Street, Suite 500,\n"
+	       "Boston, MA 02110-1335, USA.\n";
 }
 
 void HDSPMixerAboutText::draw()
-- 
1.7.2.3
