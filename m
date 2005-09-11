From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Mixer improvements
Date: Sun, 11 Sep 2005 12:51:17 +0100
Message-ID: <43241A35.8080903@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

See below for current sndrv_ctl_elem_info structure.

I would like to add to this structure the following elements:
1) Unsigned integer index to percent <-> dB function.
I would implement in alsa-lib an array of functions, each doing a 
conversion of a different type. This index would select which conversion 
routine to use for this particular mixer element. A value of 0 in this 
index would indicate that no conversion function is currently 
implemented for this mixer control and would therefore be backward 
compatible as by default, unused integers in a structure are given a 
value of 0.
2) Integer for Analog or Digital path. This will indicate which side of 
the ADC and DAC converter the mixer control is. This is particularly 
useful when trying to set mic capture levels, capture limiting and 
sampling accuracy. 0 = Digital, 1 = Analog
For example, One would probably want to set the digital(After ADC) mixer 
controls all to 0dB level, so one gets exact samples from the ADC all 
the way to the application, but one would want to adjust the mixer 
controls before the ADC in order to avoid clipping.
3) Link information.
Like USB and HDA sound cards, they have a linked list showing which 
mixer element is connected to which other mixer element. I would like to 
implement this for PCI sound cards. Maybe if we used exactly the same 
method as the USB one, we could

Points 1 and 2 I would like to implement immeadiately, with points 3 a 
nice to have.

4) Alternatively, we could implement this in alsa-lib, and just add 
something to the card info structure that would uniquely identify a 
sound card. e.g. General device name and a unique subdevice ID. So that 
all the various Audigy 2 cards would use a different config file in 
alsa-lib. We could make the device name a dir, and the subdevice ID the 
actual config file.

Can someone please tell me which is the prefered method 1-3 or 4?

Extract from asound.h:
struct sndrv_ctl_elem_info {
         struct sndrv_ctl_elem_id id;    /* W: element ID */
         enum sndrv_ctl_elem_type type;  /* R: value type - 
SNDRV_CTL_ELEM_TYPE_* */
         unsigned int access;            /* R: value access (bitmask) - 
SNDRV_CTL_ELEM_ACCESS_* */
         unsigned int count;             /* count of values */
         pid_t owner;                    /* owner's PID of this control */
         union {
                 struct {
                         long min;               /* R: minimum value */
                         long max;               /* R: maximum value */
                         long step;              /* R: step (0 variable) */
                 } integer;
                 struct {
                         long long min;          /* R: minimum value */
                         long long max;          /* R: maximum value */
                         long long step;         /* R: step (0 variable) */
                 } integer64;
                 struct {
                         unsigned int items;     /* R: number of items */
                         unsigned int item;      /* W: item number */
                         char name[64];          /* R: value name */
                 } enumerated;
                 unsigned char reserved[128];
         } value;
         union {
                 unsigned short d[4];            /* dimensions */
                 unsigned short *d_ptr;          /* indirect */
         } dimen;
         unsigned char reserved[64-4*sizeof(unsigned short)];
};


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
