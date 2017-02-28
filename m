From: kbuild test robot <fengguang.wu@intel.com>
Subject: [sound:topic/cht-whiskey-cove 1/3]
 include/acpi/acpi_bus.h:32:21: sparse: expected ; at end of declaration
Date: Wed, 1 Mar 2017 03:23:43 +0800
Message-ID: <201703010322.H9i9KLfp%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DD7C266718
 for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2017 20:23:59 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git topic/cht-whiskey-cove
head:   fe0334695c856dbdbeea861a5eb76f5ddc0dbaa9
commit: fbba8603f93e60c68116197326cdbbceee0b875b [1/3] mfd: Add Cherrytrail WhiskeyCove PMIC driver
reproduce:
        # apt-get install sparse
        git checkout fbba8603f93e60c68116197326cdbbceee0b875b
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/linux/compiler.h:253:8: sparse: attribute 'no_sanitize_address': unknown attribute
>> include/acpi/acpi_bus.h:32:21: sparse: expected ; at end of declaration
   include/acpi/acpi_bus.h:32:21: sparse: Expected } at end of struct-union-enum-specifier
   include/acpi/acpi_bus.h:32:21: sparse: got handles
   include/acpi/acpi_bus.h:33:1: sparse: Expected ; at the end of type declaration
   include/acpi/acpi_bus.h:33:1: sparse: got }
   include/acpi/acpi_bus.h:37:1: sparse: Expected ; at end of declaration
   include/acpi/acpi_bus.h:37:1: sparse: got acpi_extract_package
   include/acpi/acpi_bus.h:40:1: sparse: Expected ; at end of declaration
   include/acpi/acpi_bus.h:40:1: sparse: got acpi_evaluate_integer
   include/acpi/acpi_bus.h:44:1: sparse: Expected ; at end of declaration
   include/acpi/acpi_bus.h:44:1: sparse: got acpi_evaluate_reference
   include/acpi/acpi_bus.h:49:1: sparse: Expected ; at end of declaration
   include/acpi/acpi_bus.h:49:1: sparse: got acpi_evaluate_ost
   include/acpi/acpi_bus.h:53:1: sparse: Expected ; at end of declaration
   include/acpi/acpi_bus.h:53:1: sparse: got acpi_get_physical_device_location
   include/acpi/acpi_bus.h:55:34: sparse: Expected ) in function declarator
   include/acpi/acpi_bus.h:55:34: sparse: got handle
   include/acpi/acpi_bus.h:56:13: sparse: Expected ; at end of declaration
   include/acpi/acpi_bus.h:56:13: sparse: got acpi_execute_simple_method
   include/acpi/acpi_bus.h:58:13: sparse: Expected ; at end of declaration
   include/acpi/acpi_bus.h:58:13: sparse: got acpi_evaluate_ej0
   include/acpi/acpi_bus.h:59:13: sparse: Expected ; at end of declaration
   include/acpi/acpi_bus.h:59:13: sparse: got acpi_evaluate_lck
   include/acpi/acpi_bus.h:60:33: sparse: Expected ) in function declarator
   include/acpi/acpi_bus.h:60:33: sparse: got handle
   include/acpi/acpi_bus.h:61:33: sparse: Expected ) in function declarator
   include/acpi/acpi_bus.h:61:33: sparse: got handle
   include/acpi/acpi_bus.h:62:34: sparse: Expected ) in function declarator
   include/acpi/acpi_bus.h:62:34: sparse: got handle
   include/acpi/acpi_bus.h:64:33: sparse: Expected ) in function declarator
   include/acpi/acpi_bus.h:64:33: sparse: got handle
   include/acpi/acpi_bus.h:65:50: sparse: Expected ) in function declarator
   include/acpi/acpi_bus.h:65:50: sparse: got handle
   include/acpi/acpi_bus.h:69:37: sparse: Expected ) in function declarator
   include/acpi/acpi_bus.h:69:37: sparse: got handle
   include/acpi/acpi_bus.h:75:17: sparse: Expected ) in function declarator
   include/acpi/acpi_bus.h:75:17: sparse: got &&
>> include/acpi/acpi_bus.h:75:9: sparse: Trying to use reserved word 'if' as identifier
   include/acpi/acpi_bus.h:78:9: sparse: Expected ; at the end of type declaration
   include/acpi/acpi_bus.h:78:9: sparse: got }
   include/acpi/acpi_bus.h:81:1: sparse: Expected ; at the end of type declaration
   include/acpi/acpi_bus.h:81:1: sparse: got }
   include/acpi/acpi_bus.h:326:21: sparse: expected ; at end of declaration
   include/acpi/acpi_bus.h:326:21: sparse: Expected } at end of struct-union-enum-specifier
   include/acpi/acpi_bus.h:326:21: sparse: got gpe_device
   include/acpi/acpi_bus.h:334:1: sparse: Expected ; at the end of type declaration
   include/acpi/acpi_bus.h:334:1: sparse: got }
   include/acpi/acpi_bus.h:356:21: sparse: expected ; at end of declaration
   include/acpi/acpi_bus.h:356:21: sparse: Expected } at end of struct-union-enum-specifier
   include/acpi/acpi_bus.h:356:21: sparse: got handle
   include/acpi/acpi_bus.h:382:1: sparse: Expected ; at the end of type declaration
   include/acpi/acpi_bus.h:382:1: sparse: got }
   include/acpi/acpi_bus.h:387:21: sparse: expected ; at end of declaration
   include/acpi/acpi_bus.h:387:21: sparse: Expected } at end of struct-union-enum-specifier
   include/acpi/acpi_bus.h:387:21: sparse: got handle
   include/acpi/acpi_bus.h:393:1: sparse: Expected ; at the end of type declaration
   include/acpi/acpi_bus.h:393:1: sparse: got }
   include/acpi/acpi_bus.h:478:47: sparse: Expected ) in function declarator
   include/acpi/acpi_bus.h:478:47: sparse: got ,
   include/acpi/acpi_bus.h:479:42: sparse: Expected ) in function declarator
   include/acpi/acpi_bus.h:479:42: sparse: got ,
   include/acpi/acpi_bus.h:480:45: sparse: Expected ) in function declarator
   include/acpi/acpi_bus.h:480:45: sparse: got ,
   include/acpi/acpi_bus.h:490:37: sparse: Expected ) in function declarator
   include/acpi/acpi_bus.h:490:37: sparse: got handle
   include/acpi/acpi_bus.h:491:58: sparse: Expected ) in function declarator
   include/acpi/acpi_bus.h:491:58: sparse: got handle
   include/acpi/acpi_bus.h:493:13: sparse: Expected ; at end of declaration
   include/acpi/acpi_bus.h:493:13: sparse: got acpi_bus_get_status_handle
   include/acpi/acpi_bus.h:497:36: sparse: Expected ) in function declarator
   include/acpi/acpi_bus.h:497:36: sparse: got handle
   include/acpi/acpi_bus.h:503:39: sparse: Expected ) in function declarator
   include/acpi/acpi_bus.h:503:39: sparse: got handle
   include/acpi/acpi_bus.h:505:44: sparse: Expected ) in function declarator
   include/acpi/acpi_bus.h:505:44: sparse: got handle
   include/acpi/acpi_bus.h:508:38: sparse: Expected ) in function declarator
   include/acpi/acpi_bus.h:508:38: sparse: got handle
   include/acpi/acpi_bus.h:520:31: sparse: Expected ) in function declarator
   include/acpi/acpi_bus.h:520:31: sparse: got handle
   include/acpi/acpi_bus.h:522:13: sparse: Expected ; at end of declaration
   include/acpi/acpi_bus.h:522:13: sparse: got acpi_bus_get_ejd
   include/acpi/acpi_bus.h:582:54: sparse: Expected ) in function declarator
   include/acpi/acpi_bus.h:582:54: sparse: got handle
   include/acpi/acpi_bus.h:588:13: sparse: Expected ; at end of declaration
   include/acpi/acpi_bus.h:588:13: sparse: got acpi_add_pm_notifier
   include/acpi/acpi_bus.h:590:13: sparse: Expected ; at end of declaration
   include/acpi/acpi_bus.h:590:13: sparse: got acpi_remove_pm_notifier
   include/acpi/acpi_bus.h:74:33: sparse: undefined identifier 'handle'
   include/acpi/acpi_bus.h:77:17: sparse: symbol 'obj' has multiple initializers (originally initialized at include/acpi/acpi_bus.h:74)
   include/acpi/acpi_bus.h:364:34: sparse: symbol 'flags' redeclared with different type (originally declared at include/acpi/acpi_bus.h:330) - different base types
   include/acpi/acpi_bus.h:286:47: sparse: undefined identifier 'ACPI_D_STATE_COUNT'
>> include/acpi/acpi_bus.h:286:47: sparse: bad constant expression type
   include/acpi/acpi_bus.h:409:17: sparse: no member 'fwnode' in struct acpi_device
>> include/acpi/acpi_bus.h:409:17: sparse: unknown member
>> include/acpi/acpi_bus.h:409:17: sparse: cast from unknown type
>> include/acpi/acpi_bus.h:408:44: sparse: incompatible types in conditional expression (different types)
   include/linux/acpi.h:51:27: sparse: no member 'handle' in struct acpi_device
   drivers/mfd/intel_soc_pmic_chtwc.c:104:18: sparse: undefined identifier 'acpi_evaluate_integer'
   In file included from drivers/mfd/intel_soc_pmic_chtwc.c:18:0:
   include/acpi/acpi_bus.h:32:2: error: unknown type name 'acpi_handle'
     acpi_handle handles[ACPI_MAX_HANDLES];
     ^~~~~~~~~~~
   include/acpi/acpi_bus.h:36:1: error: unknown type name 'acpi_status'
    acpi_status
    ^~~~~~~~~~~
   include/acpi/acpi_bus.h:38:15: warning: 'struct acpi_buffer' declared inside parameter list will not be visible outside of this definition or declaration
           struct acpi_buffer *format, struct acpi_buffer *buffer);
                  ^~~~~~~~~~~
   include/acpi/acpi_bus.h:37:28: warning: 'union acpi_object' declared inside parameter list will not be visible outside of this definition or declaration
    acpi_extract_package(union acpi_object *package,
                               ^~~~~~~~~~~
   include/acpi/acpi_bus.h:39:1: error: unknown type name 'acpi_status'
    acpi_status
    ^~~~~~~~~~~
   include/acpi/acpi_bus.h:40:23: error: unknown type name 'acpi_handle'
    acpi_evaluate_integer(acpi_handle handle,
                          ^~~~~~~~~~~
   include/acpi/acpi_bus.h:41:9: error: unknown type name 'acpi_string'
            acpi_string pathname,
            ^~~~~~~~~~~
   include/acpi/acpi_bus.h:43:1: error: unknown type name 'acpi_status'
    acpi_status
    ^~~~~~~~~~~
   include/acpi/acpi_bus.h:44:25: error: unknown type name 'acpi_handle'
    acpi_evaluate_reference(acpi_handle handle,
                            ^~~~~~~~~~~
   include/acpi/acpi_bus.h:45:4: error: unknown type name 'acpi_string'
       acpi_string pathname,
       ^~~~~~~~~~~
   include/acpi/acpi_bus.h:48:1: error: unknown type name 'acpi_status'
    acpi_status
    ^~~~~~~~~~~
   include/acpi/acpi_bus.h:49:19: error: unknown type name 'acpi_handle'
    acpi_evaluate_ost(acpi_handle handle, u32 source_event, u32 status_code,
                      ^~~~~~~~~~~
   include/acpi/acpi_bus.h:52:1: error: unknown type name 'acpi_status'
    acpi_status
    ^~~~~~~~~~~
   include/acpi/acpi_bus.h:53:35: error: unknown type name 'acpi_handle'
    acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld);
                                      ^~~~~~~~~~~
   include/acpi/acpi_bus.h:55:22: error: unknown type name 'acpi_handle'
    bool acpi_has_method(acpi_handle handle, char *name);
                         ^~~~~~~~~~~
   include/acpi/acpi_bus.h:56:1: error: unknown type name 'acpi_status'
    acpi_status acpi_execute_simple_method(acpi_handle handle, char *method,
    ^~~~~~~~~~~
   include/acpi/acpi_bus.h:56:40: error: unknown type name 'acpi_handle'
    acpi_status acpi_execute_simple_method(acpi_handle handle, char *method,
                                           ^~~~~~~~~~~
   include/acpi/acpi_bus.h:58:1: error: unknown type name 'acpi_status'
    acpi_status acpi_evaluate_ej0(acpi_handle handle);
    ^~~~~~~~~~~
   include/acpi/acpi_bus.h:58:31: error: unknown type name 'acpi_handle'
    acpi_status acpi_evaluate_ej0(acpi_handle handle);
                                  ^~~~~~~~~~~
   include/acpi/acpi_bus.h:59:1: error: unknown type name 'acpi_status'
    acpi_status acpi_evaluate_lck(acpi_handle handle, int lock);
    ^~~~~~~~~~~
   include/acpi/acpi_bus.h:59:31: error: unknown type name 'acpi_handle'
    acpi_status acpi_evaluate_lck(acpi_handle handle, int lock);
                                  ^~~~~~~~~~~
   include/acpi/acpi_bus.h:60:21: error: unknown type name 'acpi_handle'
    bool acpi_ata_match(acpi_handle handle);
                        ^~~~~~~~~~~
   include/acpi/acpi_bus.h:61:21: error: unknown type name 'acpi_handle'
    bool acpi_bay_match(acpi_handle handle);
                        ^~~~~~~~~~~
   include/acpi/acpi_bus.h:62:22: error: unknown type name 'acpi_handle'
    bool acpi_dock_match(acpi_handle handle);
                         ^~~~~~~~~~~
   include/acpi/acpi_bus.h:64:21: error: unknown type name 'acpi_handle'
    bool acpi_check_dsm(acpi_handle handle, const u8 *uuid, u64 rev, u64 funcs);
                        ^~~~~~~~~~~
   include/acpi/acpi_bus.h:65:38: error: unknown type name 'acpi_handle'
    union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const u8 *uuid,
                                         ^~~~~~~~~~~
   include/acpi/acpi_bus.h:69:25: error: unknown type name 'acpi_handle'
    acpi_evaluate_dsm_typed(acpi_handle handle, const u8 *uuid, u64 rev, u64 func,
                            ^~~~~~~~~~~
   include/acpi/acpi_bus.h:70:30: error: unknown type name 'acpi_object_type'
       union acpi_object *argv4, acpi_object_type type)
                                 ^~~~~~~~~~~~~~~~
   In file included from drivers/mfd/intel_soc_pmic_chtwc.c:18:0:
   include/acpi/acpi_bus.h:286:40: error: 'ACPI_D_STATE_COUNT' undeclared here (not in a function)
     struct acpi_device_power_state states[ACPI_D_STATE_COUNT]; /* Power states (D0-D3Cold) */
                                           ^~~~~~~~~~~~~~~~~~
   include/acpi/acpi_bus.h:326:2: error: unknown type name 'acpi_handle'
     acpi_handle gpe_device;
     ^~~~~~~~~~~
   include/acpi/acpi_bus.h:356:2: error: unknown type name 'acpi_handle'
     acpi_handle handle;  /* no handle for fixed hardware */
     ^~~~~~~~~~~
   include/acpi/acpi_bus.h:387:2: error: unknown type name 'acpi_handle'
     acpi_handle handle;
     ^~~~~~~~~~~

vim +32 include/acpi/acpi_bus.h

8a0662d9 Rafael J. Wysocki 2014-11-04  26  #include <linux/property.h>
^1da177e Linus Torvalds    2005-04-16  27  
^1da177e Linus Torvalds    2005-04-16  28  /* TBD: Make dynamic */
^1da177e Linus Torvalds    2005-04-16  29  #define ACPI_MAX_HANDLES	10
^1da177e Linus Torvalds    2005-04-16  30  struct acpi_handle_list {
^1da177e Linus Torvalds    2005-04-16  31  	u32 count;
^1da177e Linus Torvalds    2005-04-16 @32  	acpi_handle handles[ACPI_MAX_HANDLES];
^1da177e Linus Torvalds    2005-04-16  33  };
^1da177e Linus Torvalds    2005-04-16  34  
^1da177e Linus Torvalds    2005-04-16  35  /* acpi_utils.h */
^1da177e Linus Torvalds    2005-04-16  36  acpi_status
4be44fcd Len Brown         2005-08-05  37  acpi_extract_package(union acpi_object *package,
4be44fcd Len Brown         2005-08-05  38  		     struct acpi_buffer *format, struct acpi_buffer *buffer);
^1da177e Linus Torvalds    2005-04-16  39  acpi_status
4be44fcd Len Brown         2005-08-05  40  acpi_evaluate_integer(acpi_handle handle,
^1da177e Linus Torvalds    2005-04-16  41  		      acpi_string pathname,
27663c58 Matthew Wilcox    2008-10-10  42  		      struct acpi_object_list *arguments, unsigned long long *data);
^1da177e Linus Torvalds    2005-04-16  43  acpi_status
4be44fcd Len Brown         2005-08-05  44  acpi_evaluate_reference(acpi_handle handle,
^1da177e Linus Torvalds    2005-04-16  45  			acpi_string pathname,
^1da177e Linus Torvalds    2005-04-16  46  			struct acpi_object_list *arguments,
^1da177e Linus Torvalds    2005-04-16  47  			struct acpi_handle_list *list);
275c58d7 Toshi Kani        2012-05-23  48  acpi_status
05730c19 Jiang Liu         2014-02-19  49  acpi_evaluate_ost(acpi_handle handle, u32 source_event, u32 status_code,
05730c19 Jiang Liu         2014-02-19  50  		  struct acpi_buffer *status_buf);
^1da177e Linus Torvalds    2005-04-16  51  
38ac0f1b Matthew Garrett   2012-05-11  52  acpi_status
8ede06ab Feng Tang         2012-08-21  53  acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld);
952c63e9 Jiang Liu         2013-06-29  54  
952c63e9 Jiang Liu         2013-06-29  55  bool acpi_has_method(acpi_handle handle, char *name);
0db98202 Jiang Liu         2013-06-29  56  acpi_status acpi_execute_simple_method(acpi_handle handle, char *method,
0db98202 Jiang Liu         2013-06-29  57  				       u64 arg);
7d2421f8 Jiang Liu         2013-06-29  58  acpi_status acpi_evaluate_ej0(acpi_handle handle);
7d2421f8 Jiang Liu         2013-06-29  59  acpi_status acpi_evaluate_lck(acpi_handle handle, int lock);
ebf4df8d Jiang Liu         2013-06-29  60  bool acpi_ata_match(acpi_handle handle);
ebf4df8d Jiang Liu         2013-06-29  61  bool acpi_bay_match(acpi_handle handle);
ebf4df8d Jiang Liu         2013-06-29 @62  bool acpi_dock_match(acpi_handle handle);
952c63e9 Jiang Liu         2013-06-29  63  
c7e16e52 Jerry Hoemann     2016-04-11  64  bool acpi_check_dsm(acpi_handle handle, const u8 *uuid, u64 rev, u64 funcs);
a65ac520 Jiang Liu         2013-12-19  65  union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const u8 *uuid,
c7e16e52 Jerry Hoemann     2016-04-11  66  			u64 rev, u64 func, union acpi_object *argv4);
a65ac520 Jiang Liu         2013-12-19  67  
a65ac520 Jiang Liu         2013-12-19  68  static inline union acpi_object *
c7e16e52 Jerry Hoemann     2016-04-11  69  acpi_evaluate_dsm_typed(acpi_handle handle, const u8 *uuid, u64 rev, u64 func,
a65ac520 Jiang Liu         2013-12-19  70  			union acpi_object *argv4, acpi_object_type type)
a65ac520 Jiang Liu         2013-12-19  71  {
a65ac520 Jiang Liu         2013-12-19  72  	union acpi_object *obj;
a65ac520 Jiang Liu         2013-12-19  73  
a65ac520 Jiang Liu         2013-12-19  74  	obj = acpi_evaluate_dsm(handle, uuid, rev, func, argv4);
a65ac520 Jiang Liu         2013-12-19 @75  	if (obj && obj->type != type) {
a65ac520 Jiang Liu         2013-12-19  76  		ACPI_FREE(obj);
a65ac520 Jiang Liu         2013-12-19  77  		obj = NULL;
a65ac520 Jiang Liu         2013-12-19  78  	}

:::::: The code at line 32 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
